import 'package:falatu_mobile/commons/core/data/models/user_model.dart';
import 'package:falatu_mobile/commons/core/data/services/http_service/http_service.dart';
import 'package:falatu_mobile/commons/core/domain/entities/api_result.dart';
import 'package:falatu_mobile/commons/utils/errors/errors.dart';
import 'package:falatu_mobile/commons/utils/errors/handle_error.dart';
import 'package:falatu_mobile/commons/utils/helpers/url_helpers.dart';
import 'package:falatu_mobile/onboard/core/data/datasources/onboard_datasource.dart';
import 'package:falatu_mobile/onboard/core/data/models/create_user_model.dart';

class OnboardDatasourceImpl implements OnboardDatasource {
  final HttpService client;

  OnboardDatasourceImpl(this.client);

  @override
  Future<ApiResult<UserModel>> createUser(CreateUserModel params) async {
    try {
      final url = UrlHelpers.getApiBaseUrl(moduleName: 'users', path: '');
      final json = params.toJson();
      final response = await client.post(url, data: json);
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
