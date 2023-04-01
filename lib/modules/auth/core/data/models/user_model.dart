import 'package:falatu/modules/auth/core/domains/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.firstName,
      required super.lastName,
      required super.picture,
      // required super.authToken,
      required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        picture: json['picture'],
        // authToken: json['authToken'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'picture': picture,
      // 'authToken': authToken,
      'email': email,
    };
  }
}
