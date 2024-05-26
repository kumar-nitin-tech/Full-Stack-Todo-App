import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/common/constants.dart';
import 'package:todo_app/data/model/todo/all_todos.dart';
import 'package:todo_app/presentation/home/Component/todo_component.dart';
import 'package:todo_app/presentation/home/TasksTab/task_tabs_viewmodel.dart';

Widget taskTabScreen(List<Todo>? allTodos,Function() getAllTodo){
  return Scaffold(
      body: Column(
        children: [
          if(allTodos != null)
          getListTodo(allTodos,getAllTodo),
          if(allTodos == null)
            const Center(child: Text("The list is empty"),)
        ],
      )
  );
}

Widget getListTodo(List<Todo> allTodos,Function() getAllTodo){
  return Expanded(child: ListView.builder(
      itemCount: allTodos.length,
      itemBuilder: (context,int index){
        return todoComponent(allTodos[index], context,getAllTodo);
      })
  );
}
