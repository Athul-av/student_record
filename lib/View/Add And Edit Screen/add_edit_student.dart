import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/Model/db/functions/db_functions.dart';
import 'package:student_manager/Model/db/model/enum_class.dart';
import 'package:student_manager/Model/db/model/student_model.dart';

import 'package:student_manager/Controller/provider/student_provider.dart';
import 'package:student_manager/View/Add%20And%20Edit%20Screen/widgets/custom_text_form_fileld.dart';
import 'package:student_manager/View/widgets/snack_bar.dart';

import 'package:student_manager/View/Home%20Screen/home_screen.dart';
import 'package:student_manager/View/widgets/style.dart';

class AddStudent extends StatelessWidget {
  AddStudent({
    Key? key,
    this.name,
    this.age,
    this.email,
    this.number,
    this.index,
    this.id,
    required this.type,
  }) : super(key: key);

  final Actiontype type;
  final String? name;
  final String? age;
  final String? email;
  final String? number;
  final int? index;
  final String? id;

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();
  
  final _numberController = TextEditingController();

  final _emailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (type == Actiontype.editScreen) {
      _nameController.text = name.toString();
      _ageController.text = age.toString();
      _emailController.text = email.toString();
      _numberController.text = number.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: type == Actiontype.addScreen
            ? const Text(
                "Add Student Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              )
            : const Text(
                "Edit Student Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             const CircleAvatar(
                radius: 48,
                child: Icon(Icons.person,size: 48,)
                ,
              ),
               
                height20,
                CustomTextFormField(
                  controller: _nameController,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "   Enter Student Full Name!";
                    }else{
                      return null;
                    }
                  }),
                  keyboardType: TextInputType.name,
                  prefixIcon: Icons.person_outline_rounded,
                  labelText: 'Student Name',
                  
                ),
                height20,
                CustomTextFormField(
                  controller: _ageController,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "   Enter Student Age!";
                    } else if (value.length > 2) {
                      return "   Enter Student Age Correct Format";
                    } else {
                      return null;
                    }
                  }),
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.calendar_month_outlined,
                  labelText: 'Student Age',
                ),
                height20,
                CustomTextFormField(
                  controller: _numberController,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "   Enter Parent's Mobile Number!";
                    } else if (value.length != 10) {
                      return "   Mobile number must be of 10 digit";
                    } else {
                      return null;
                    }
                  }),
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.phone_android_rounded,
                  labelText: "Mobile Number",
                  
                ),
                height20,
                CustomTextFormField(
                  controller: _emailController,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Enter Student Email";
                    } else {
                      return null;
                    }
                  }),
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  labelText: 'Student Email',
                  suffixText: '@gmail.com  ',
                ),
               const SizedBox(height: 13,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        if (type == Actiontype.addScreen) {
                          if (formKey.currentState!.validate() ) {
                            addButtonCicked(context);
                          } 
                        } else {
                          if (formKey.currentState!.validate()) {
                            addButtonCicked(context);
                            
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                      ),
                      label: const Text(
                        'Add',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addButtonCicked(context) async {
    final studentFunction = Provider.of<StudentDb>(context, listen: false);
    final stName = _nameController.text.trim();
    final stAge = _ageController.text.trim();
    final stNumber = _numberController.text.trim();
    final stEmail = _emailController.text.trim();

    if (stName.isEmpty ||
        stAge.isEmpty ||
        stNumber.isEmpty ||
        stEmail.isEmpty) {
      return;
    } else {
      final student = StudentModel(
        name: stName,
        age: stAge,
        number: stNumber,
        email: stEmail,
        id: type == Actiontype.addScreen
            ? DateTime.now().microsecondsSinceEpoch.toString()
            : id.toString(),
      );
      type == Actiontype.addScreen
          ? studentFunction
              .addStudent(student)
              
          : studentFunction
              .editStudent(index!.toInt(), student, context);
             
      if (type == Actiontype.editScreen) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ), (route) => false);

        CustomSnackBar()
            .snackBar(context, 'Successfully edited records', const  Color.fromARGB(255, 23, 135, 226));
      } else {
        Provider.of<StudentProvider>(context, listen: false)
            .getAllData(context);

        CustomSnackBar().snackBar(context, 'Successfully added',const Color.fromARGB(255, 60, 150, 63));

        Navigator.of(context).pop();
      }
    }
  }
}

