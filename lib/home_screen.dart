import 'package:flutter/material.dart';
import 'package:todo/task1_update_todo/todolist.dart';
import 'package:todo/task2_todos_api/todos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildHomeScreenColumn(context),
    );
  }

  buildHomeScreenColumn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildCustomButton(
            context: context,
            label: "Task 1 Update Todos",
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const TodoList()));
            },
            color: Colors.purpleAccent,
          ),
          const SizedBox(height: 20,),
          buildCustomButton(
            context: context,
            label: "Task 2 Todos API",
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const ToDosScreen()));
            },
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

  Widget buildCustomButton({
  required BuildContext context,
    required String label,
    required VoidCallback onPressed,
    required Color color,
}){
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child:  Text(label,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18
          ),),
      ),
    );
  }



}
