
import "package:falatu_mobile/app/core/domain/entities/sign_in_entity.dart";

class SignInModel extends SignInEntity {
  const SignInModel({required super.email, required super.password});

  factory SignInModel.fromObject(SignInEntity object) =>
      SignInModel(email: object.email, password: object.password);

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
