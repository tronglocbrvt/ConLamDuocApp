import 'package:conlamduoc/core/define.dart';


import 'package:conlamduoc/model/mapper_object.dart';

import 'package:conlamduoc/util/reflector.dart';

@reflector
class Challenge extends MapperObject {
	int id;
	String nameChallenge;
	String describe;
  String img;
	int coins; // coin sau mỗi Challenge
	bool isActive; 
	String field; // lĩnh vực challenge
	DateTime createdAt; // ngày update Challenge
	DateTime endTime; // giới hạn time Challenge
}
