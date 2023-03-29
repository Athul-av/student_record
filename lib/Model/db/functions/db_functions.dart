import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_manager/Model/db/model/student_model.dart';

// ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
class StudentDb with ChangeNotifier {
  static List<StudentModel> studentList = [];

  Future<void> addStudent(StudentModel value) async {
    final studnetDb = await Hive.openBox<StudentModel>('Student_db');
    await studnetDb.put(value.id, value);
    studentList.add(value);
    // getAllStudents();
  }

  static Future<List<StudentModel>> getAllStudents() async {
    final studnetDb = await Hive.openBox<StudentModel>('student_DB');
    studentList.clear();
    studentList.addAll(studnetDb.values);
    return studentList;
  }

  Future<void> deleteStutent(context, String index) async {
    final studnetDb = await Hive.openBox<StudentModel>('student_DB');
    await studnetDb.delete(index);
    getAllStudents();
  }

  Future<void> editStudent(int id, StudentModel value, context) async {
    final studnetDb = await Hive.openBox<StudentModel>('Student_db');
    await studnetDb.putAt(id, value);
    getAllStudents();
  }
}
