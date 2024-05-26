import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/model/auth/register_model.dart';
import 'package:todo_app/data/remote/api_module.dart';

class RegisterViewModel{

  Future<String> getToken(RegisterModel registerModel)  async {
    final jsonResponse =  await APIClient().registerCall(registerModel);
    if(jsonResponse['success']){
      var token = jsonResponse['response'];
      final pref = await SharedPreferences.getInstance();
      pref.setString("token", token);
      return token;
    }else{
      var error = jsonResponse['response'];
      return error;
    }
  }
}