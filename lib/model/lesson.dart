import 'package:conlamduoc/model/mapper_object.dart';
import 'package:conlamduoc/util/reflector.dart';

@reflector
class Lesson extends MapperObject {
  int id;
  String nameLesson;
  String content;
  int coins;
  bool isActive;
  String lessonField;
  String thumbnailImageUrl;
  String webUrl;
  DateTime createdAt;
}
