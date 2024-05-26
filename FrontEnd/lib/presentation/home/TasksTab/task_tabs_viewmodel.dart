
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/model/todo/all_todos.dart';
import 'package:todo_app/data/remote/api_module.dart';

class TaskTabViewModel{
  Future<List<Todo>> getAllTodos() async{
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");
    if(token != null) {
      final todoResponse = await APIClient().getAllTodo(token);
      if (todoResponse['success'] == true) {
        return todoResponse['response'];
      } else {
        return todoResponse['response'];
      }
    }else{
      throw Exception("Access Denied: Unauthorized access");
    }
  }

}