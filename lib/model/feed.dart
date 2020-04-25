import 'package:conlamduoc/model/mapper_object.dart';
import 'package:conlamduoc/util/reflector.dart';

@reflector
class Feed extends MapperObject {
  int id;
  int challengeId;
  int challengeCoins;
  String challengeName;
  int userId;
  String avatarUrl;
  String fullName;
  String content;
  bool isLiked;
  String imageUrl;
  String videoUrl;
  DateTime createdAt;
}
