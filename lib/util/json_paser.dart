import 'dart:convert';

import 'package:reflectable/reflectable.dart';
import 'package:reflectable/mirrors.dart';

import 'package:conlamduoc/util/reflector.dart';

class JsonParser {
  final Map<String, ClassMirror> classes = <String, ClassMirror>{};

  JsonParser() {
    for (ClassMirror classMirror in reflector.annotatedClasses) {
      classes[classMirror.simpleName] = classMirror;
    }
  }

  bool isMapperObject(String className) {
    return classes[className] != null;
  }

  T decode<T> (dynamic input) {
    if (input is String) {
      Map content = json.decode(input);
      return _parse(content, T);
    } else if (input is Map) {
      return _parse(input, T);
    } else {
      throw new UnsupportedError('The specified JSON input type ($T) is invalid.');
    }
  }

  dynamic _parse(Map map, Type returnType) {
    ClassMirror classMirror = reflector.reflectType(returnType);
    dynamic instance = classMirror.newInstance("", []);
    InstanceMirror instanceMirror = reflector.reflect(instance);

    classMirror.declarations.forEach((String key, DeclarationMirror mirror) {
      dynamic newValue = map[key];
      if (newValue != null) {
        Type castType;
        if (mirror is VariableMirror) {
          castType = mirror.reflectedType;
        } else if (mirror is MethodMirror) {
          castType = mirror.reflectedReturnType;
        } else {
          throw new UnsupportedError('Can\'t cast to $castType + $key + $mirror');
        }

        String strProType = castType.toString();
        ClassMirror proMirror = classes[strProType];

        if (proMirror == null) {
          // property type is not reflection type
          if (castType == bool) {
            instanceMirror.invokeSetter(key, _castToBool(newValue));
          }
          else if (castType == DateTime) {
            instanceMirror.invokeSetter(key, _castToDateTime(newValue));
          }
          else if (strProType.indexOf('List') == 0) {
            String clsName = strProType.substring(5, strProType.length - 1);
            ClassMirror cls = classes[clsName];
            if (cls == null) {
              // normal list
              instanceMirror.invokeSetter(key, _castToList(newValue, clsName));
            }
            else {
              // list of reflection item
              List res = [];
              List list = newValue;
              for (Map item in list) {
                var obj = _parse(item, cls.reflectedType);
                res.add(obj);
              }
              instanceMirror.invokeSetter(key, res);
            }
          }
          else {
            instanceMirror.invokeSetter(key, newValue);
          }
        }
        else if (proMirror.isEnum) {
          // property type is enum
          List values = proMirror.invokeGetter('values');
          instanceMirror.invokeSetter(key, values[newValue]);
        } else {
          // property type is reflection type
          var newObj = _parse(newValue, castType);
          instanceMirror.invokeSetter(key, newObj);
        }
      }
    });

    return instance;
  }

  String encode(Object input) {
    Map res = _encodeObject(input);

    return json.encode(res);
  }

  Map _encodeObject(Object input) {
    if (input == null) {
      return null;
    } else {
      InstanceMirror instanceMirror = reflector.reflect(input);
      ClassMirror classMirror = instanceMirror.type;

      Map res = {};

      classMirror.declarations.forEach((key, mirror) {
        Type type;

        if (mirror is VariableMirror) {
          type = mirror.reflectedType;
        } else if (mirror is MethodMirror && mirror.isGetter) {
          type = mirror.reflectedReturnType;
        }

        if (type != null) {
          var val = instanceMirror.invokeGetter(key);

          String strCastType = type.toString();

          if (strCastType.indexOf('List') == 0) {
            String clsName = strCastType.substring(5, strCastType.length - 1);
            ClassMirror cls = classes[clsName];
            if (cls == null) {
              res[key] = val;
            } else {
              List arr = [];
              List list = val ?? [];
              for (var item in list) {
                var obj = _encodeObject(item);
                arr.add(obj);
              }
              res[key] = arr;
            }
          } else {
            ClassMirror proMirror = classes[strCastType];

            if (val is DateTime) {
              res[key] = val.millisecondsSinceEpoch;
            } else if (val is bool) {
              res[key] = val ? 1 : 0;
            } else if (proMirror == null) {
              res[key] = val;
            } else if (proMirror.isEnum) {
              List values = proMirror.invokeGetter('values');
              int i = val == null ? 0 : values.indexOf(val); // enum value is index
              res[key] = i;
            } else {
              res[key] = _encodeObject(val);
            }
          }
        }
      });

      return res;
    }
  }
}

final JsonParser objectParser = JsonParser();

bool _castToBool(dynamic val) {
  if (val is int) {
    return val != 0;
  }

  if (val is bool) {
    return val;
  }

  if (val is String) {
    return val != '0';
  }

  return false;
}

DateTime _castToDateTime(dynamic val) {
  if (val is int) {
    if (val > 1000000000000) {
      val = val ~/ 1000;
    }
    return DateTime.fromMillisecondsSinceEpoch(val * 1000).toUtc(); // server return secount. but fromMillisecondsSinceEpoch used millisecond => x 1000
  }

  if (val is DateTime) {
    return val;
  }

  if (val is String) {
    int temp = int.parse(val);
    if (temp > 1000000000000) {
      temp = temp ~/ 1000;
    }
    return DateTime.fromMillisecondsSinceEpoch(temp * 1000);
  }

  return null;
}

List _castToList(List list, String kl) {
  switch (kl) {
    case 'String': return list.cast<String>();
    case 'int': return list.cast<int>();
  }
  return list;
}
