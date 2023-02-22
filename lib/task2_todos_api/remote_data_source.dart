import 'package:dio/dio.dart';
import 'package:todo/task2_todos_api/todo_model.dart';

class RemoteDataSource{
  Dio dio = Dio();
  Future<List<ToDoModel>> getTodos()async{
    try{
      List<ToDoModel> todos = [];
      final response = await dio.get("https://jsonplaceholder.typicode.com/todos");
      if(response.statusCode == 200){
        todos.addAll(
            List.from(response.data.map((element) => ToDoModel.fromJson(element)),
            )
        );
      }
      return todos;
    }catch(error){
      print(error);
      return [];
    }
  }
}

