import 'package:falatu_mobile/commons/core/data/models/user_model.dart';
import 'package:falatu_mobile/commons/core/data/services/http_service/http_service.dart';
import 'package:falatu_mobile/commons/core/domain/entities/api_result.dart';
import 'package:falatu_mobile/commons/utils/errors/errors.dart';
import 'package:falatu_mobile/commons/utils/errors/handle_error.dart';
import 'package:falatu_mobile/commons/utils/helpers/url_helpers.dart';
import 'package:falatu_mobile/sign_in/core/data/datasources/sign_in_datasource.dart';
import 'package:falatu_mobile/sign_in/core/data/models/sign_in_model.dart';

class SignInDatasourceImpl implements SignInDatasource {
  final HttpService _client;

  SignInDatasourceImpl({required HttpService client}) : _client = client;

  @override
  Future<ApiResult<UserModel>> signIn(SignInModel params) async {
    try {
      final url = UrlHelpers.getApiBaseUrl(moduleName: 'auth');
      final response = await _client.post(url, data: params.toJson());
      return ApiResult.success(UserModel.fromJson(response.data));
    } on ApiError catch (e) {
      final error = handleError(e.statusCode, message: e.message);
      return ApiResult.error(error);
    } catch (e) {
      return ApiResult.error(UnknownError(message: e.toString()));
    }
  }
}
