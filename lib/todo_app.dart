import 'package:flutter/material.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/task1_update_todo/todolist.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomeScreen(),
    );
  }
}