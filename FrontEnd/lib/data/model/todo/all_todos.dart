
class Todo {
  String id;
  String userId;
  String title;
  String description;
  bool completed;
  String createdAt;
  String updatedAt;
  int v;

  Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
  factory Todo.fromJson(Map<String, dynamic> json)=> Todo(
      id: json["_id"],
      userId: json["userId"],
      title: json["title"],
      description: json["description"],
      completed: json["completed"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      v: json["__v"]
  );
}
