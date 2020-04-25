import 'dart:convert';

import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/model/lesson.dart';
import 'package:conlamduoc/model/mapper_object.dart';
import 'package:conlamduoc/model/user.dart';
import 'package:conlamduoc/util/json_paser.dart';
import 'package:flutter/services.dart';

class RawDataManager {
  static List<User> userList = List<User>();
  static List<Lesson> lessonList = List<Lesson>();

  static void initRawData() async {
    //init users
    // String jsonContent = await rootBundle.loadString("assets/data/users/user1.json");
    // User user = MapperObject.create<User>(jsonContent);
    // userList.add(user);

    // jsonContent = await rootBundle.loadString("assets/data/users/user2.json");
    // user = MapperObject.create<User>(jsonContent);
    // userList.add(user);

    String jsonContent =
        await rootBundle.loadString("assets/data/users/userList.json");
    Map<String, dynamic> body = json.decode(jsonContent);
    dynamic data = body['data']; // data just can be List or Map type.
    if (data != null) {
      if (data is List) {
        List<User> list = [];
        data.forEach((obj) {
          list.add(_parse<User>(obj));
        });
        userList = list;
      } else {
        userList.add(_parse<User>(data));
      }
    }

    // Init lessons
    jsonContent = await rootBundle.loadString("assets/data/lessons/lessonList.json");
    body = json.decode(jsonContent);
    data = body['data']; // data just can be List or Map type.
    if (data != null) {
      if (data is List) {
        List<Lesson> list = [];
        data.forEach((obj) {
          list.add(_parse<Lesson>(obj));
        });
        lessonList = list;
      } else {
        lessonList.add(_parse<Lesson>(data));
      }
    }
  }

  static dynamic _parse<E>(dynamic obj) {
    String className = E.toString();
    // if E is reflection class => parse with MapperObject
    if (objectParser.isMapperObject(className)) {
      return MapperObject.create<E>(obj);
    } else {
      return obj;
    }
  }
}
