class MarkTodo {
  String id;
  bool completed;

  MarkTodo({
    required this.id,
    required this.completed,
  });

  Map<String,dynamic> toJson(){
    return {
      "_id": id,
      "completed": completed
    };
  }

}