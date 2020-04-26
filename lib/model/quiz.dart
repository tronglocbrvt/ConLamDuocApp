import 'package:conlamduoc/core/define.dart';

import 'package:conlamduoc/model/mapper_object.dart';

import 'package:conlamduoc/util/reflector.dart';

@reflector
class Quiz extends MapperObject {
	int id;
	String question;
	List<String> options;
	bool isActive; 
	Answer answer;
	int grade;
	QuizLevel level; // cấp độ câu hỏi
	String field; // lĩnh vực câu hỏi
	DateTime createdAt; // ngày update câu hỏi
	DateTime endTime; // giới hạn time câu hỏi
}