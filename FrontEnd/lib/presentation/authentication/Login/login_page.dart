import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/model/auth/login_model.dart';
import 'package:todo_app/presentation/authentication/Login/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValid = false;

  void _login() async{
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var loginModel = LoginModel(
          email: emailController.text,
          password: passwordController.text
      );
      final navigator = Navigator.of(context);
      final prefs = await SharedPreferences.getInstance();
      final token = await LoginViewModel().loginToken(loginModel);
      print(token);
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
    return Scaffold(
      //background color :
      backgroundColor: Colors.grey[300],
      //body
      //we use safe area widget to space the top status bar and notch
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  "Welcome Back !",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 50),

              //email text field
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
                      controller: emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                          errorText: (_isNotValid)? "Enter the password": null
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              //password text field
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

              const SizedBox(height: 15),

              // Sign In Button

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: (){
                    _login();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12.0)
                    ),
                    child: const Center(
                      child: Text(
                        'Sign In',
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
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account ?"),
                    const SizedBox(width: 5),

                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, 'signUpPage');
                      },
                      child: const Text(
                          "Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
