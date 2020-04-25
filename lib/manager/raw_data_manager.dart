import 'package:conlamduoc/model/lesson.dart';
import 'package:conlamduoc/model/mapper_object.dart';
import 'package:conlamduoc/model/user.dart';
import 'package:flutter/services.dart';

class RawDataManager {
  static List<User> userList = List<User>();
  static List<Lesson> lessonList = List<Lesson>();

  static void initRawData() async {
    // Init users
    String jsonContent =
        await rootBundle.loadString("assets/data/users/user1.json");
    User user = MapperObject.create<User>(jsonContent);
    userList.add(user);

    jsonContent = await rootBundle.loadString("assets/data/users/user2.json");
    user = MapperObject.create<User>(jsonContent);
    userList.add(user);

    // Init lessons
    for (int i=1; i<=6; ++i) {
      jsonContent = await rootBundle.loadString("assets/data/lessons/lesson$i.json");
      Lesson lesson = MapperObject.create<Lesson>(jsonContent);
      lessonList.add(lesson);
    }
  }
}
