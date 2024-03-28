class RegisterUserModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  bool get isEmpty =>
      name.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      passwordConfirmation.isEmpty;

  RegisterUserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
}
