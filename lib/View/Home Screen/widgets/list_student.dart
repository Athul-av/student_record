import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/Model/db/model/enum_class.dart';
import 'package:student_manager/Controller/provider/student_provider.dart';
import 'package:student_manager/View/Add%20And%20Edit%20Screen/add_edit_student.dart';
import 'package:student_manager/View/Home%20Screen/widgets/DetailsScreen.dart';
import 'package:student_manager/View/widgets/snack_bar.dart';
import 'package:student_manager/View/widgets/style.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, value, child) {
        return value.dataFound.isEmpty
            ? const Center(
                heightFactor: 30,
                child: Text(
                  'No Item Found!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.separated(
                physics: const ScrollPhysics(),
                separatorBuilder: (context, index) {
                  return height10;
                },
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = value.dataFound[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 27,
                     child: Icon(Icons.person,size: 29,), 
                    ),
                    title: Text(
                      data.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                    subtitle: Text(
                      'Age - ${data.age}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        onPressedDelete(context, data.id.toString());
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailsScreen(data: data,findex: index,))); 
                    },
                  );
                },
                itemCount: value.dataFound.length,
              );
      },
    );
  }
}

void onPressedDelete(BuildContext context, String index) {
  showCupertinoModalPopup(
    context: context,
    builder: ((context) {
      return CupertinoAlertDialog(
        title: const Text(
          "Delete Student?",
          style: textStyle2,
        ),
        content: const Text(
          "This student will be permanently deleted from this list.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<StudentProvider>(context, listen: false).deleteData(
                index,
                context,
              );
              // Provider.of<StudentProvider>(context, listen: false)
              //     .getAllData(context);
              CustomSnackBar()
                  .snackBar(context, 'Successfully deleted!', Colors.red);

              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    }),
  );
}
