import 'dart:io';

class CreateUserEntity {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final File? picture;

  CreateUserEntity({required this.name, required this.email, required this.password, required this.confirmPassword, required this.picture});
}