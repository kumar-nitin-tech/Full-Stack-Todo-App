import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/model/todo/all_todos.dart';
import 'package:todo_app/data/model/todo/delete_todo.dart';
import 'package:todo_app/data/model/todo/mark_todo.dart';
import 'package:todo_app/data/remote/api_module.dart';

Future<String> deleteTask(String todoId) async{
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString('token');
  if(token != null){
    DeleteTodo deleteTodo = DeleteTodo(id: todoId);
    final response = await APIClient().deleteTodo(deleteTodo, token);
    if(response['success'] == true){
      return response['response'];
    }else{
      return response['response'];
    }
  }else{
    return "UnAuthorized Access";
  }
}

Future<String> markTask(String todoId) async{
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString('token');
  if(token != null){
    MarkTodo markTodo = MarkTodo(id: todoId, completed: true);
    final response = await APIClient().markTodo(markTodo, token);
    if(response['success'] == true){
      return response['response'];
    }else{
      return response['response'];
    }
  }else{
    return "UnAuthorized Access";
  }
}

Future<void> displayDialogToDeleteTask(BuildContext context, String todoId,Function() getAllTodo) async{
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text("Are you really want to do delete?"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: (){
                final deleteTaskResponse = deleteTask(todoId);
                deleteTaskResponse.then((value) => {
                  Fluttertoast.showToast(msg: value,toastLength: Toast.LENGTH_SHORT)
                });
                Navigator.pop(context);
                getAllTodo();
                },
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(14),
                child: const Text("Yes"),
              ),
            ),

            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(14),
                child: const Text("No"),
              ),
            ),
          ],
        );
      }
  );
}

  Widget todoComponent(Todo todo, BuildContext context,Function() getAllTodo) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
         child: Padding(padding: const EdgeInsets.all(10),
                child:Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                todo.title,
                              style: TextStyle(
                                color: (todo.completed == true)? Colors.green : Colors.red
                              ),
                            ),
                            const SizedBox(
                               height: 10,
                            ),
                            Text(todo.description)
                          ],
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: (){
                                    final markTaskResponse = markTask(todo.id);
                                    markTaskResponse.then((value) => {
                                      Fluttertoast.showToast(msg: value,toastLength: Toast.LENGTH_SHORT)
                                    });
                                    getAllTodo();
                                },
                                icon: const Icon(Icons.check)
                            ),

                            IconButton(
                                onPressed: (){
                                  displayDialogToDeleteTask(context, todo.id,getAllTodo);
                                },
                                icon: const Icon(Icons.delete)
                            )
                          ],
                        )
                      ],
                ),
         )
      )
    );
  }
