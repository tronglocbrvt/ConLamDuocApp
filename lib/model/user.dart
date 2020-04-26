import 'package:conlamduoc/core/define.dart';
import 'package:conlamduoc/model/mapper_object.dart';
import 'package:conlamduoc/util/reflector.dart';

@reflector
class User extends MapperObject {
  int userId;
  String username;
  String parentEmail;
  String avatar;
  String fullName;
  DateTime birthday;
  String parentPhone;
  Gender gender;
  DateTime createdAt;

  @override
  bool operator ==(other) {
    if (other is User) {
      return userId == other.userId;
    }
    return false;
  }

  String getUsername() {
    return username;
  }
}
