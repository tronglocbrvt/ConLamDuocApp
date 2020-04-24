import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/model/mapper_object.dart';
import 'package:conlamduoc/model/user.dart';
import 'package:flutter/services.dart';

class RawDataManager{

  static List<User> userList = List<User>();

  

  static void initRawData()  async {
    //init users
    String jsonContent = await rootBundle.loadString("assets/data/users/user1.json");
    User user1 = MapperObject.create<User>(jsonContent);
    userList.add(user1);


  }

}

