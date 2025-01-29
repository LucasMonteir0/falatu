import "dart:io";

import "package:equatable/equatable.dart";

class SignUpEntity extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final File? picture;

  const SignUpEntity(
      {required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.picture});

  @override
  List<Object?> get props => [name, email, password, confirmPassword, picture];
}
