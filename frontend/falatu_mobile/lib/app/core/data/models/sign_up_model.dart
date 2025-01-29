import "package:falatu_mobile/app/core/domain/entities/sign_up_entity.dart";

class SignUpModel extends SignUpEntity {
  const SignUpModel(
      {required super.name,
      required super.email,
      required super.password,
      required super.confirmPassword,
      required super.picture});

  factory SignUpModel.fromObject(SignUpEntity object) => SignUpModel(
      name: object.name,
      email: object.email,
      password: object.password,
      confirmPassword: object.confirmPassword,
      picture: object.picture);

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      };
}
