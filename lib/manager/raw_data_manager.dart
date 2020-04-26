import 'dart:convert';

import 'package:conlamduoc/model/feed.dart';
import 'package:conlamduoc/model/lesson.dart';
import 'package:conlamduoc/model/mapper_object.dart';
import 'package:conlamduoc/model/quiz.dart';
import 'package:conlamduoc/model/user.dart';
import 'package:conlamduoc/model/challenge.dart';
import 'package:conlamduoc/util/json_paser.dart';
import 'package:flutter/services.dart';

class RawDataManager {
  static List<User> userList = List<User>();
  static List<Lesson> lessonList = List<Lesson>();
  static List<Feed> feedList = List<Feed>();
  static List<Challenge> challengeList = List<Challenge>();
  static List<Quiz> quizList = List<Quiz>();

  static void initRawData() async {
    _initUsers();
    _initLessons();
    _initFeeds();
    _initChallenges();
    _initQuizzes();
  }

  static void _initUsers() async {
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
  }

  static void _initLessons() async {
    String jsonContent =
        await rootBundle.loadString("assets/data/lessons/lessonList.json");
    Map<String, dynamic> body = json.decode(jsonContent);
    dynamic data = body['data']; // data just can be List or Map type.
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

  static void _initFeeds() async {
    String jsonContent =
        await rootBundle.loadString("assets/data/feeds/feedList.json");
    Map<String, dynamic> body = json.decode(jsonContent);
    dynamic data = body['data']; // data just can be List or Map type.
    if (data != null) {
      if (data is List) {
        List<Feed> list = [];
        data.forEach((obj) {
          list.add(_parse<Feed>(obj));
        });
        feedList = list;
      } else {
        feedList.add(_parse<Feed>(data));
      }
    }
  }

  static void _initChallenges() async {
    String jsonContent =
        await rootBundle.loadString("assets/data/challenge/challengeList.json");
    Map<String, dynamic> body = json.decode(jsonContent);
    dynamic data = body['data']; // data just can be List or Map type.
    if (data != null) {
      if (data is List) {
        List<Challenge> list = [];
        data.forEach((obj) {
          list.add(_parse<Challenge>(obj));
        });
        challengeList = list;
      } else {
        challengeList.add(_parse<Challenge>(data));
      }
    }
  }

  static void _initQuizzes() async {
    String jsonContent =
        await rootBundle.loadString("assets/data/quizzes/quizList.json");
    Map<String, dynamic> body = json.decode(jsonContent);
    dynamic data = body['data']; // data just can be List or Map type.
    if (data != null) {
      if (data is List) {
        List<Quiz> list = [];
        data.forEach((obj) {
          list.add(_parse<Quiz>(obj));
        });
        quizList = list;
      } else {
        quizList.add(_parse<Quiz>(data));
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
