import 'package:flutter/material.dart';
import 'package:todo/task2_todos_api/remote_data_source.dart';
import 'package:todo/task2_todos_api/todo_model.dart';

class ToDosScreen extends StatefulWidget {
  const ToDosScreen({Key? key}) : super(key: key);

  @override
  State<ToDosScreen> createState() => _ToDosScreenState();
}

class _ToDosScreenState extends State<ToDosScreen> {

  RemoteDataSource remoteDataSource = RemoteDataSource();
  List<ToDoModel> todos = [];
  
  @override
  void initState() {
    super.initState();
   getTodos();
  }

 Future<void> getTodos()async{
    await remoteDataSource.getTodos().then((value){
      setState(() {
        todos.addAll(value);
      });
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        title: const Text('Todos from Api',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
      ),
      body: buildTodosScreenBody(),
    );
  }

  Widget buildTodosScreenBody() {
    return Center(
      child:todos.length != 0
          ? buildListOfTodos()
          : buildLoadingWidget(),
    );
  }

  buildListOfTodos() {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    todos[index].title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                  ),
                ),
                Checkbox(
                  value: todos[index].isCompleted,
                  activeColor: const Color(0xff1b5e22),
                  onChanged: (val){
                    setState(() {
                      todos[index].isCompleted = !todos[index].isCompleted;
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget buildLoadingWidget() {
    return  const Center(
      child: CircularProgressIndicator(
        color: Colors.orangeAccent,
      ),
    );
  }


}
