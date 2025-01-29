import "package:falatu_mobile/app/core/data/datasources/auth/auth_datasource.dart";
import "package:falatu_mobile/app/core/data/models/sign_in_model.dart";
import "package:falatu_mobile/app/core/data/models/sign_in_response_model.dart";
import "package:falatu_mobile/app/core/data/models/sign_up_model.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";
import "package:falatu_mobile/commons/core/data/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/errors/handle_error.dart";
import "package:falatu_mobile/commons/utils/get_it.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";

class AuthDatasourceImpl implements AuthDatasource {
  final HttpService _client = getIt.get<HttpService>();

  AuthDatasourceImpl();

  @override
  Future<ApiResult<SignInResponseModel>> signIn(SignInModel params) async {
    try {
      final url = UrlHelpers.getApiBaseUrl(moduleName: "auth");
      final response = await _client.post(url, data: params.toJson());
      return ApiResult.success(SignInResponseModel.fromJson(response.data));
    } on ApiError catch (e) {
      final error = handleError(e.statusCode, message: e.message);
      return ApiResult.error(error);
    } catch (e) {
      return ApiResult.error(UnknownError(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<UserModel>> signUp(SignUpModel params) async {

    try {
      final url = UrlHelpers.getApiBaseUrl(moduleName: "users", path: "");
      final json = params.toJson();
      final response = await _client.post(url, data: json);
      final user = UserModel.fromJson(response.data);
      return ApiResult.success(user);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode, message: e.message);
      return ApiResult.error(error);
    } catch (e) {
      return ApiResult.error(UnknownError(message: e.toString()));
    }
  }
}
