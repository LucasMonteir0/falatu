import "package:falatu_mobile/app/core/data/datasources/auth/auth_datasource.dart";
import "package:falatu_mobile/app/core/data/models/sign_in_model.dart";
import "package:falatu_mobile/app/core/data/models/sign_up_model.dart";
import "package:falatu_mobile/commons/core/data/models/auth_credentials_model.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/errors/handle_error.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";

class AuthDatasourceImpl implements AuthDatasource {
  final HttpService _client;

  AuthDatasourceImpl(this._client);

  @override
  Future<ResultWrapper<AuthCredentialsModel>> signIn(SignInModel params) async {
    try {
      final url = UrlHelpers.getApiBaseUrl(moduleName: "auth");
      final response = await _client.post(url, data: params.toJson());
      return ResultWrapper.success(AuthCredentialsModel.fromJson(response.data));
    } on ApiError catch (e) {
      final error = handleError(e.statusCode, message: e.message);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }

  @override
  Future<ResultWrapper<UserModel>> signUp(SignUpModel params) async {
    try {
      final url = UrlHelpers.getApiBaseUrl(moduleName: "users", path: "");
      final json = await params.toFormData();
      final response = await _client.post(url, data: json);
      final user = UserModel.fromJson(response.data);
      return ResultWrapper.success(user);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode, message: e.message);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }
}
