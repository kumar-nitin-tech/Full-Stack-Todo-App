import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/presentation/authentication/Login/login_page.dart';
import 'package:todo_app/presentation/authentication/Register/sign_up_page.dart';
import 'package:todo_app/presentation/home/TasksTab/tasks_tab.dart';
import 'package:todo_app/presentation/home/todo_home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  print(pref.getString("token"));
  runApp(MyApp(token: pref.getString('token'),));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({
    @required this.token,
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (token != null)? const TodoScreen() : const SignUpPage(),
      routes: {
        'signUpPage' : (context) => const SignUpPage(),
        'loginPage' : (context) => const LoginPage(),
        'todoScreen': (context) => const TodoScreen(),
      },
    );
  }
}