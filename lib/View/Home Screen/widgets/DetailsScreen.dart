import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_manager/Model/db/model/enum_class.dart';
import 'package:student_manager/View/Add%20And%20Edit%20Screen/add_edit_student.dart';
import 'package:student_manager/View/widgets/style.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key,required this.data,required this.findex,});

  final data;
  final findex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea( 
        child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,top: 10),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ),
                                  ],
                                ),
                                height20,
                            const  CircleAvatar(
                                radius: 56,
                               child: Icon(Icons.person,size: 60,), 
                              ),
                                SizedBox(height: 30,),
                                Text(
                                  data.name.toUpperCase(),
                                  style:TextStyle(fontWeight: FontWeight.bold,fontSize: 28)
                                ),
                                height20,
                                Text(
                                  'Age - ${data.age}',
                                  style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Color.fromARGB(255, 128, 128, 128))
                                ),
                                height10,
                                Text(
                                  'Number - ${data.number}',
                                  style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Color.fromARGB(255, 128, 128, 128))
                                ),
                                height10,
                                Text(
                                  'Email - ${data.email}@gmail.com',
                                  style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Color.fromARGB(255, 128, 128, 128))
                                ),
                                height20,
                                Wrap(),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return AddStudent(
                                            type: Actiontype.editScreen,
                                            name: data.name,
                                            age: data.age,
                                            email: data.email,
                                            number: data.number,
                                            id: data.id.toString(),
                                          
                                            index: findex,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                  label: const Text('Edit'),
                                ),
                              ],
                            ),
      )
                          );

  }
}