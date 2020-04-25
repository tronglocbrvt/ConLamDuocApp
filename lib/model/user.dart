import 'package:conlamduoc/core/define.dart';


import 'package:conlamduoc/model/mapper_object.dart';

import 'package:conlamduoc/util/reflector.dart';

@reflector
class User extends MapperObject {
  int userId;
  String username;
  String email;
  String img;
  String name;
  String nameSlug;
  bool isActive;
  String deviceToken;
  DateTime birthday;
  String phone;
  String country;
  String city;
  Gender gender;
  num weight;
  num height;
  String accessToken;
  DateTime lastLogin;

  DateTime addDate;
  DateTime updateDate;


  @override
  bool operator == (other) {
    if (other is User) {
      return userId == other.userId;
    }
    return false;
  }

  String getUsername(){
    return username;
  }
  
}
