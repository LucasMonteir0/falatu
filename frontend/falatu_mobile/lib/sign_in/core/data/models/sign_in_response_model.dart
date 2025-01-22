import 'package:falatu_mobile/sign_in/core/domain/entities/sign_in_response_entity.dart';

class SignInResponseModel extends SignInResponseEntity {
  SignInResponseModel(
      {required super.userId,
      required super.accessToken,
      required super.refreshToken});

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      SignInResponseModel(
        userId: json['uid'],
        accessToken: json['access'],
        refreshToken: json['refresh'],
      );
}
