import "package:dio/dio.dart";
import "package:falatu_mobile/app/core/domain/entities/sign_up_entity.dart";
import "package:falatu_mobile/commons/utils/extensions/file_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:falatu_mobile/commons/utils/helpers/http_send_file_helper.dart";

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

  Future<FormData> toFormData() async {
    final imageFile = await picture.let((v) async =>
        await HttpSendFilesHelper.fromBytes(
            v, DioMediaType("image", v.extension)));

    return FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "picture": imageFile,
    });
  }
}
