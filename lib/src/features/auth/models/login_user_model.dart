class LoginUserModel {
  final String email;
  final String password;

  bool get isEmpty => email.isEmpty || password.isEmpty;

  LoginUserModel({required this.email, required this.password});
}
