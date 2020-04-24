import 'dart:convert';

import 'package:reflectable/reflectable.dart';
import 'package:reflectable/mirrors.dart';

import 'package:conlamduoc/util/reflector.dart';
import 'package:conlamduoc/util/json_paser.dart';


@reflector
class MapperObject {
  static T create<T>(dynamic input) {
    return objectParser.decode<T>(input);
  }

  String toJson() {
    return objectParser.encode(this);
  }

  Map toMap() {
    return json.decode(toJson());
  }

  void copy(dynamic obj) {
    if (obj.runtimeType == this.runtimeType) {
      ClassMirror classMirror = reflector.reflectType(this.runtimeType);


      InstanceMirror thisMirror = reflector.reflect(this);
      InstanceMirror objMirror = reflector.reflect(obj);

      classMirror.declarations.forEach((String key, DeclarationMirror mirror) {
        if (mirror is VariableMirror || (mirror is MethodMirror && mirror.isGetter)) {
          thisMirror.invokeSetter(key, objMirror.invokeGetter(key));
        }
      });
    }
  }
}