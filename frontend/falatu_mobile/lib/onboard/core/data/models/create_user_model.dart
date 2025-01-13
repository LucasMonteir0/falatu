import 'dart:io';

class CreateUserModel {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final File? picture;

  CreateUserModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.picture});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
