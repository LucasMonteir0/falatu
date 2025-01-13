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
  Future<ApiResult> createUser(CreateUserModel params) async {
    try {
      final url = UrlHelpers.getApiBaseUrl(moduleName: 'users', path: '');
      final json = params.toJson();
      final result = await client.post(url, data: json);
      return ApiResult.success(result.data);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode, message: e.message);
      return ApiResult.error(error);
    } catch (e) {
      return ApiResult.error(UnknownError(message: e.toString()));
    }
  }
}
