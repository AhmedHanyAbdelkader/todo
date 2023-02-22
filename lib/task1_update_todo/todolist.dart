import 'package:flutter/material.dart';
import 'dbhelper.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  final todoController = TextEditingController();
  final updateController = TextEditingController();
  bool validated = true;
  String errorMessage = "";
  String todoAdded = "";
  var myTodos = [];
  List<Widget> listOfCards = [];
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context,snap){
      if (snap.hasData == null) {
        return const Center(
          child: Text("NO Data"),
        );
      }  else{
        if (myTodos.length == 0 ) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Tasks"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: showAlertDialog,
              backgroundColor: Colors.purple,
              child: const Icon(Icons.add),
            ),
            body: const Center(
              child: Text("No Tasks Available",style: TextStyle(
                fontSize: 25.0,
              ),),
            ),
          );
        }  else{
          return Scaffold(
              appBar: AppBar(
                title: const Text("My Tasks"),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: showAlertDialog,
                backgroundColor: Colors.purple,
                child: const Icon(Icons.add),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: listOfCards,
                ),
              )
          );
        }
      }
    },future: query(),);
  }

  void showAlertDialog() {
    todoController.text = "";
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add Task"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    controller: todoController,
                    style: const TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(
                      errorText: validated ? null : errorMessage,
                    ),
                    onChanged: (value) {
                      todoAdded = value;
                    },
                  ),
                  const SizedBox(height: 15,),
                  MaterialButton(
                      color: Colors.purple,
                      child: const Text("Add", style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                      ),),
                      onPressed: () {
                        if (todoController.text.isEmpty) {
                          setState(() {
                            errorMessage = " Cannot be empty";
                            validated = false;
                          });
                        } else if (todoController.text.length > 100) {
                          setState(() {
                            errorMessage = " Too Many Characters";
                            validated = false;
                          });
                        } else {
                          addTodo();
                        }
                      }
                  )
                ],
              ),

            );
          });
        });
  }

  void addTodo() async {
    Map<String, dynamic> todo = {
      DatabaseHelper.columnName: todoAdded,
    };
    final id = await dbHelper.insert(todo);
    print(id);
    Navigator.of(context, rootNavigator: true).pop();
    todoAdded = "";
    setState(() {
      validated = true;
      errorMessage = "";
    });
  }

  Future<bool> query() async {
    myTodos = [];
    listOfCards=[];
    var listOfAllTodos = await dbHelper.queryAllTodos();
    listOfAllTodos?.forEach((task) {
      myTodos.add(task.toString());
      listOfCards.add(
        GestureDetector(
          onLongPress: (){
            updateTask(task: task);
          },
          child: Card(
            elevation: 5.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                title: Text(task['todo'],
                  style: const TextStyle(
                      fontSize: 18.0
                  ),),

                trailing: IconButton(
                  onPressed: (){
                    dbHelper.deleteTodo(task['id']);
                    print("Task Deleted");
                    setState(() {
                    });
                  },
                  icon: Icon(Icons.delete,color: Colors.red,),
                ),

              ),
            ),
          ),
        ),
      );
    });
    return Future.value(true);
  }


   updateTask({required Map<String,dynamic> task}) {
    showUpdateAlertDialog(task: task);
  }

  void showUpdateAlertDialog({Map<String, dynamic>? task}) {
    updateController.text = task!['todo'];
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Update Task"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    controller: updateController,
                    style: const TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(
                      errorText: validated ? null : errorMessage,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  MaterialButton(
                      color: Colors.purple,
                      child: const Text("Update", style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                      ),),
                      onPressed: () {
                        if (updateController.text.isEmpty) {
                          setState(() {
                            errorMessage = " Cannot be empty";
                            validated = false;
                          });
                        }
                        else if (todoController.text.length > 100) {
                          setState(() {
                            errorMessage = " Too Many Characters";
                            validated = false;
                          });
                        }
                        else {
                          update(taskId: task['id']);
                        }
                      }
                  )
                ],
              ),

            );
          });
        });
  }

  void update({required int  taskId}) async{
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: taskId,
      DatabaseHelper.columnName: updateController.text,
    };
    final rowsAffected = await dbHelper.update(row);
    debugPrint('updated $rowsAffected row(s)');
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {
      validated = true;
      errorMessage = "";
    });

  }


}
// appBar: AppBar(
// title: Text("My Tasks"),
// ),
// body: SingleChildScrollView(
// child: Column(
// children: [
// ],
// ),
// ),
// floatingActionButton: FloatingActionButton(
// onPressed: showAlertDialog,
// child: Icon(Icons.add),
// backgroundColor: Colors.purple,
// ),