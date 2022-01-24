// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/pages/update_student_page.dart';

class ListStudentPage extends StatefulWidget {
  ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  // IMPORTANT STUFF FOR FIREBASE
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  // FOR DELETION OF DATA
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> deleteUser(id) {
    // print("User deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print("user deleted"))
        .catchError((error) => print('Failed to delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          'Action',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                  ]),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          TableCell(
                              child: Center(
                            child: Text(
                              storedocs[i]['name'],
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )),
                          TableCell(
                            child: Center(
                              child: Text(
                                storedocs[i]['email'],
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          TableCell(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateStudentPage(id: storedocs[i]['id']),
                                    ),
                                  )
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    {deleteUser(storedocs[i]['id'])},
                                icon: Icon(Icons.delete),
                                color: Colors.orange,
                              )
                            ],
                          ))
                        ]),
                  ]
                ],
              ),
            ),
          );
        });
  }
}
