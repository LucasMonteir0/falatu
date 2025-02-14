import "package:falatu_mobile/commons/core/data/datasources/auth/auth_commons_datasource.dart";
import "package:falatu_mobile/commons/core/data/models/auth_credentials_model.dart";
import "package:falatu_mobile/commons/core/data/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/errors/handle_error.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";

class AuthCommonsDatasourceImpl implements AuthCommonsDatasource {
  final HttpService _httpClient;
  final SharedPreferencesService _preferences;

  AuthCommonsDatasourceImpl(
      HttpService httpClient, SharedPreferencesService preferences)
      : _preferences = preferences,
        _httpClient = httpClient;

  @override
  Future<ResultWrapper<AuthCredentialsEntity>> updateAccessToken() async {
    try {
      final refreshToken = _preferences.getUserRefreshToken();
      final url =
          UrlHelpers.getApiBaseUrl(path: "refresh-token", moduleName: "auth");
      final result = await _httpClient.post(url, data: {"token": refreshToken});

      final model = AuthCredentialsModel.fromJson(result.data);
      await _preferences.setUserRefreshToken(model.refreshToken);
      await _preferences.setUserAccessToken(model.accessToken);
      return ResultWrapper<AuthCredentialsEntity>.success(model);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode, message: e.message);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }

  @override
  Future<bool> signOut() async {
    return _preferences.removeAuthCaches();
  }
}
