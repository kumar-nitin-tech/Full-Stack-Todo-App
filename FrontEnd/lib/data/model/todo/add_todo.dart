class AddTodo {
  String title;
  String description;
  bool completed;

  AddTodo({
    required this.title,
    required this.description,
    required this.completed,
  });

  Map<String,dynamic> toJson(){
    return {
      "title": title,
      "description": description,
      "completed": completed
    };
  }

}
