import 'package:falatu_mobile/onboard/core/domain/entities/create_user_entity.dart';

class CreateUserModel extends CreateUserEntity {
  CreateUserModel(
      {required super.name,
      required super.email,
      required super.password,
      required super.confirmPassword,
      required super.picture});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
