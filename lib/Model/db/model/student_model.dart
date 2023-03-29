import 'package:hive_flutter/hive_flutter.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String number;

  @HiveField(4)
  final String email;
 

  StudentModel({
 
    required this.name,
    required this.age,
    required this.number,
    required this.email,
    this.id,
  });
}
