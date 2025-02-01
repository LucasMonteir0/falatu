import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";

class AuthCredentialsModel extends AuthCredentialsEntity {
  const AuthCredentialsModel(
      {required super.userId,
      required super.accessToken,
      required super.refreshToken});

  factory AuthCredentialsModel.fromJson(Map<String, dynamic> json) =>
      AuthCredentialsModel(
        userId: json["uid"],
        accessToken: json["access"],
        refreshToken: json["refresh"],
      );
}
