import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/remote/api_module.dart';
import 'package:todo_app/presentation/home/CompletedTaskTab/completed_tab.dart';
import 'package:todo_app/presentation/home/TasksTab/tasks_tab.dart';
import 'package:todo_app/presentation/home/AddTasks/add_tasks.dart';

import '../../common/constants.dart';
import '../../data/model/todo/add_todo.dart';
import '../../data/model/todo/all_todos.dart';
import 'TasksTab/task_tabs_viewmodel.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  @override
  void initState() {
    super.initState();
    getAllTodo();
  }

  List<Todo>? allTodos;
  void removeToken() async{
    final pref = await SharedPreferences.getInstance();
    pref.remove("token");
  }

  void getAllTodo() async{
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    if(token != null){
      allTodos = await TaskTabViewModel().getAllTodos();
    }else{
      allTodos = [];
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("Todo-App"),
            actions: <Widget>[
              PopupMenuButton(
                itemBuilder: (context) =>[
                  const PopupMenuItem(
                      value: 1,
                      child: Text("LogOut")
                  )
                ],
                onSelected: (value)=>{
                  if(value == 1){
                    removeToken(),
                    Navigator.popAndPushNamed(context, "signUpPage")
                  }
                },
              )
            ],
          ),
          body: taskTabScreen(allTodos, getAllTodo),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),
            backgroundColor: Colors.blue,
            onPressed: () {
              displayDialogToAddTask(context,getAllTodo);
            },
            child: const Icon(Icons.add),
          ),
        );
  }
}
