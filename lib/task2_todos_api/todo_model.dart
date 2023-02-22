class ToDoModel{
  int id;
  String title;
  bool isCompleted;

  ToDoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json){
    return ToDoModel(
        id: json['id'],
        title: json['title'],
        isCompleted: json['completed'],
    );
  }

}