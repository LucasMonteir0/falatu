import "package:falatu_mobile/commons/core/data/datasources/users/users_commons_datasource.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/core/domain/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/errors/handle_error.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";

class UsersCommonsDatasourceImpl implements UsersCommonsDatasource {
  final HttpService _http;
  final SharedPreferencesService _preferences;

  UsersCommonsDatasourceImpl(this._http, this._preferences);

  @override
  Future<ResultWrapper<List<UserEntity>>> getNonFriends() async {
    try {
      final url =
          UrlHelpers.getApiBaseUrl(moduleName: "users", path: "non-friends");
      final userId = _preferences.getUserId();
      final response =
          await _http.get(url, queryParameters: {"userId": userId});
      final result = (response.data as List<dynamic>)
          .map((e) => UserModel.fromJson(e))
          .toList();
      return ResultWrapper.success(result);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }

  @override
  Future<ResultWrapper<UserEntity>> getUser() async {
    try {
      final url = UrlHelpers.getApiBaseUrl(moduleName: "users");
      final userId = _preferences.getUserId();
      final response = await _http.get(url, queryParameters: {"id": userId});

      return ResultWrapper.success(UserModel.fromJson(response.data));
    } on ApiError catch (e) {
      final error = handleError(e.statusCode);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }
}
