class DeleteTodo {
  String id;

  DeleteTodo({
    required this.id,
  });

  Map<String,dynamic> toJson(){
    return {
      "_id": id,
    };
  }
}

