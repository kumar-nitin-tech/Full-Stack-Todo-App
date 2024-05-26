
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/common/constants.dart';
import 'package:todo_app/data/model/todo/add_todo.dart';
import 'package:todo_app/presentation/home/AddTasks/add_tasks_viewmodel.dart';

import '../../../data/model/todo/all_todos.dart';
import '../TasksTab/task_tabs_viewmodel.dart';

Future<void> displayDialogToAddTask(BuildContext context, Function() getAllTodo) async{
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void addTask() async{
    AddTodo addTodo = AddTodo(
        title: titleController.text,
        description: descriptionController.text,
        completed: false
    );
    print(addTodo);
    if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
      final todo = await AddTaskViewModel().addTask(addTodo);
      Navigator.pop(context);
      getAllTodo();
    }
  }


  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
              )
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                addTask();
              },
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(14),
                child: const Text("Add"),
              ),
            ),
          ],
        );
      }
  );
}