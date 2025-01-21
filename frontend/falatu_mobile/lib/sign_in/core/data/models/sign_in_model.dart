import 'package:falatu_mobile/sign_in/core/domain/entities/sign_in_entity.dart';

class SignInModel extends SignInEntity {
  SignInModel({required super.email, required super.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
