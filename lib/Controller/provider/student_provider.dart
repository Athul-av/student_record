import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:student_manager/Model/db/functions/db_functions.dart';
import 'package:student_manager/Model/db/model/student_model.dart';

const kImage = "assets/images/student (2).png";

class StudentProvider extends ChangeNotifier {
  List<StudentModel> dataFound = [];
 
  List<StudentModel> filterSearch = StudentDb.studentList; 


  Future<void> getAllData(context) async {
    final students = await StudentDb.getAllStudents();
    dataFound = students;
    notifyListeners();
  }

  void addStudent(data) {
    dataFound.clear();
    dataFound.addAll(data);
    notifyListeners();
  }

  void search(String keyboard) {
    List<StudentModel> results = [];
    
    if (keyboard.isEmpty) {
      results = filterSearch;
    } else {
      results = filterSearch
          .where(
            (element) => element.name.contains(
              keyboard.toLowerCase().trim(),  
            ),
          )
           .toList();
    }

    dataFound = results;
    notifyListeners();
  }

  Future<void> deleteData(String index, context) async {
    if (index.isEmpty) {
      log('No id');
    } else {
      await StudentDb().deleteStutent(context, index);
      log('deleted successfully');
    }
    notifyListeners();
  }
}
