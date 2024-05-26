import 'dart:async';
import 'dart:convert';
import 'package:todo_app/common/constants.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/data/model/auth/login_model.dart';
import 'package:todo_app/data/model/todo/add_todo.dart';
import 'package:todo_app/data/model/todo/all_todos.dart';
import 'package:todo_app/data/model/todo/delete_todo.dart';
import 'package:todo_app/data/model/todo/mark_todo.dart';
import '../model/auth/register_model.dart';

class APIClient{

  Future<Map<String,dynamic>> registerCall(RegisterModel registerModel) async {
    try {
      final response = await http.post(
          Uri.parse(registerUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(registerModel.toJson())
      );
      final responseData = jsonDecode(response.body);
      final dataResponse = responseData['data'];
      if (response.statusCode == 200) {
        final tokenData = dataResponse['token'];
        return {"success": true, "response": tokenData};
      }
      else if (response.statusCode == 409 || response.statusCode == 400) {
        final errorResponse = dataResponse['error'];
        return {
          "success": false,
          "response": errorResponse
        };
      }
      else {
        throw Exception('Failed to create account.');
      }
    }catch(err){
      throw Exception(err);
    }
  }

  Future<Map<String,dynamic>> login(LoginModel loginModel) async {
    try {
      final response = await http.post(
          Uri.parse(loginUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(loginModel.toJson())
      );
      final responseData = jsonDecode(response.body);
      final dataResponse = responseData['data'];
      if (response.statusCode == 200) {
        final tokenData = dataResponse['token'];
        return {"success": true, "response": tokenData};
      }
      else if (response.statusCode == 404 || response.statusCode == 401) {
        final errorResponse = dataResponse['error'];
        return {
          "success": false,
          "response": errorResponse
        };
      }
      else {

        throw Exception('Failed to create account.');
      }
    }catch(err){
      print(err);
      throw Exception(err);
    }
  }

  Future<Map<String,dynamic>> getAllTodo(String token) async{
    try{
      final response = await http.get(
        Uri.parse(getAllTodos),
        headers: {
          'auth': token
        }
      );
      final jsonResponse = jsonDecode(response.body);
      final dataResponse = jsonResponse['data'];
      if(response.statusCode == 200){
        final todoResponse = dataResponse['todos'] as List;
        List<Todo> allTodos = todoResponse.map((todoJson) => Todo.fromJson(todoJson)).toList();
        return {"success": true, "response": allTodos};
      }
      else if(response.statusCode == 400){
        final errorResponse = dataResponse['error'];
        return {"success": false, "response": errorResponse};
      }
      return {"success" : false, "response": "UnExpected Error occured"};
    }catch(err){
      throw Exception(err);
    }
  }

  Future<Map<String,dynamic>> addTodo(AddTodo addTodo, String token) async {
    try {
      final response = await http.post(
          Uri.parse(createTodo),
          headers: {
            "Content-Type": "application/json",
            "auth": token
          },
          body: jsonEncode(addTodo.toJson())
      );
      final responseData = jsonDecode(response.body);
      final dataResponse = responseData['data'];
      if (response.statusCode == 200) {
        final todoData = dataResponse['todo'];
        print(todoData);
        return {"success": true, "response": todoData};
      }
      else if (response.statusCode == 400) {
        final errorResponse = dataResponse['error'];
        return {
          "success": false,
          "response": errorResponse
        };
      }
      else {
        throw Exception('Failed to create account.');
      }
    }catch(err){
      throw Exception(err);
    }
  }

  Future<Map<String,dynamic>> deleteTodo(DeleteTodo deleteTodo, String token) async {
    try {
      final response = await http.post(
          Uri.parse(deleteTodoUri),
          headers:{
            "Content-Type": "application/json",
            "auth": token
          },
          body: jsonEncode(deleteTodo.toJson())
      );
      final responseData = jsonDecode(response.body);
      final dataResponse = responseData['data'];
      if (response.statusCode == 200) {
        final deleteResponse = dataResponse['msg'];
        print(deleteResponse);
        return {"success": true, "response": deleteResponse};
      }
      else if (response.statusCode == 400) {
        final errorResponse = dataResponse['error'];
        return {
          "success": false,
          "response": errorResponse
        };
      }
      else {

        throw Exception('Failed to create account.');
      }
    }catch(err){
      print(err);
      throw Exception(err);
    }
  }

  Future<Map<String,dynamic>> markTodo(MarkTodo markTodo, String token) async {
    try {
      final response = await http.post(
          Uri.parse(markTodoUri),
          headers:{
            "Content-Type": "application/json",
            "auth": token
          },
          body: jsonEncode(markTodo.toJson())
      );
      final responseData = jsonDecode(response.body);
      final dataResponse = responseData['data'];
      if (response.statusCode == 200) {
        final markResponse = dataResponse['msg'];
        return {"success": true, "response": markResponse};
      }
      else if (response.statusCode == 400) {
        final errorResponse = dataResponse['error'];
        return {
          "success": false,
          "response": errorResponse
        };
      }
      else {

        throw Exception('Failed to create account.');
      }
    }catch(err){
      print(err);
      throw Exception(err);
    }
  }

}