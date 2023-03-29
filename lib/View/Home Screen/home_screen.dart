import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/Model/db/model/enum_class.dart';
import 'package:student_manager/Controller/provider/student_provider.dart';
import 'package:student_manager/View/Add%20And%20Edit%20Screen/add_edit_student.dart';
import 'package:student_manager/View/Home%20Screen/widgets/list_student.dart';
import 'package:student_manager/View/widgets/style.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final studentProvider =Provider.of<StudentProvider>(context, listen: false);
    
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        studentProvider.getAllData(context);
      },
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,  
      appBar: AppBar(
        
        shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(45),
      ),
    ),
        title: Column(
          children: [
            const Text(
              'Student Record',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.white), 
            ),
            height10,
            Consumer<StudentProvider>(
              builder: (context, value, child) {
                return CupertinoSearchTextField(
                  backgroundColor: Color.fromARGB(255, 227, 227, 227), 
                  placeholder: 'Search Students',
                  placeholderStyle:TextStyle(color: Color.fromARGB(255, 139, 139, 139),fontSize: 13),
                  itemColor: Color.fromARGB(255, 151, 151, 151),
                  controller: searchController,
                  onChanged: (result) {
                  value.search(result);
                  },
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.indigo, 
        toolbarHeight: 110, 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudent(
                type: Actiontype.addScreen,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.person_add,
        ),
      ),
      body: SafeArea(
        child: ListView( 
          children: const [
            SizedBox(height: 15,),
            StudentList(),
          ],
        ),
      ),
    );
  }
}
