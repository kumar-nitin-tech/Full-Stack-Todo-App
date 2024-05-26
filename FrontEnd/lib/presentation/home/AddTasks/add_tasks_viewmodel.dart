import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/model/todo/add_todo.dart';
import 'package:todo_app/data/model/todo/all_todos.dart';
import 'package:todo_app/data/remote/api_module.dart';

class AddTaskViewModel{
  Future<void> addTask(AddTodo addTodo) async{
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");
    if(token != null){
      final response = await APIClient().addTodo(addTodo,token);
      if(response['success'] == true){
        print(response['response']);
        return response['response'];
      }else{
        return response['response'];
      }
    }
    else{
      throw Exception("UnAuthorize access denied");
    }
  }
}