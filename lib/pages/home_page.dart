// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/pages/add_student_page.dart';
import 'package:flutter_firebase_crud/pages/list_student_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Flutter Firebase CRUD", style: TextStyle(fontSize: 18.0),),
            ElevatedButton(onPressed: () => {
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => AddStudentPage()))
            }, child: Text("Add", style: TextStyle(fontSize: 18.0),),
            style: ElevatedButton.styleFrom(primary: Colors.deepPurple))
          ],
        ),
      ),
      body: ListStudentPage(),
    );
  }
}