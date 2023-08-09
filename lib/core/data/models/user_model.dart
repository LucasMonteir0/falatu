


import 'package:falatu/core/domains/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.firstName,
      required super.lastName,
      required super.picture,
      required super.id,
      required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        picture: json['picture'] ?? '',
        id: json['id'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'picture': picture,
      'id': id,
      'email': email,
    };
  }
}
