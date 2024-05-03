import 'package:flutter/material.dart';
import 'package:todo_app/presentation/authentication/login_page.dart';
import 'package:todo_app/presentation/authentication/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        'signUpPage' : (context) => const SignUpPage(),
        'loginPage' : (context) => const LoginPage(),
      },
    );
  }
}