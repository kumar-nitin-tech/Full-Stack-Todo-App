import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/model/auth/register_model.dart';
import 'package:todo_app/presentation/authentication/Register/register_viewmodel.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValid = false;

  void _register() async{
    if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var registerModel = RegisterModel(
          username: nameController.text,
          email: emailController.text,
          password: passwordController.text
      );
      final navigator = Navigator.of(context);
      final prefs = await SharedPreferences.getInstance();
      final token = await RegisterViewModel().getToken(registerModel);
      if(token != null){
        final tokenCheck = prefs.getString("token");
        if(tokenCheck == token) {
          navigator.popAndPushNamed("todoScreen");
        }else{
          Fluttertoast.showToast(msg: token.toString(),toastLength:Toast.LENGTH_SHORT,timeInSecForIosWeb: 1);
        }
      }else{
        Fluttertoast.showToast(msg: "Unexpected error occurred", toastLength:Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
      }
    }else{
      _isNotValid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Create a account',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        errorText: (_isNotValid)? "Enter the name": null
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email Id',
                          errorText: (_isNotValid)? "Enter the email": null
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                          errorText: (_isNotValid)? "Enter the password": null
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: (){
                    _register();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have account? ',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.popAndPushNamed(context, 'loginPage');
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
