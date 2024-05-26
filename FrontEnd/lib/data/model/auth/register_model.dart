class RegisterModel {
  String username;
  String email;
  String password;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String,dynamic> toJson(){
    return {
      "username": username,
      "email": email,
      "password": password
    };
  }
}



