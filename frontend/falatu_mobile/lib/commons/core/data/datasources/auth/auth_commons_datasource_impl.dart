import "package:falatu_mobile/commons/core/data/datasources/auth/auth_commons_datasource.dart";
import "package:falatu_mobile/commons/core/data/models/auth_credentials_model.dart";
import "package:falatu_mobile/commons/core/data/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/errors/handle_error.dart";
import "package:falatu_mobile/commons/utils/extensions/date_extensions.dart";
import "package:falatu_mobile/commons/utils/helpers/jwt_helper.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";

class AuthCommonsDatasourceImpl implements AuthCommonsDatasource {
  final HttpService _httpClient;
  final SharedPreferencesService _preferences;
  final void Function()? _onNullRefreshToken;

  AuthCommonsDatasourceImpl(
      HttpService httpClient, SharedPreferencesService preferences,
      {void Function()? onNullRefreshToken})
      : _preferences = preferences,
        _httpClient = httpClient,
        _onNullRefreshToken = onNullRefreshToken;

  @override
  Future<ResultWrapper<AuthCredentialsEntity>> updateAccessToken(
      [bool forceRefresh = false]) async {
    try {
      final refreshToken = _preferences.getUserRefreshToken();
      final accessToken = _preferences.getUserAccessToken();
      if (refreshToken == null) {
        _onNullRefreshToken?.call();
        return ResultWrapper.error(
            BadRequestError(message: "Refresh token is null"));
      }

      final isAccessTokenAvailable = accessToken != null;

      if (!forceRefresh) {
        forceRefresh = !isAccessTokenAvailable;
      }

      final now = DateTime.now();
      final refreshExpiration = JwtHelper.getExpirationDate(refreshToken);
      final accessExpiration = isAccessTokenAvailable ? JwtHelper.getExpirationDate(accessToken!) : null;

      final shouldRefresh = forceRefresh ||
          now.isAfter(refreshExpiration.subtractHours(12)) ||
          (accessExpiration != null && now.isAfter(accessExpiration.subtractHours(12)));

      if (shouldRefresh) {
        final url =
            UrlHelpers.getApiBaseUrl(path: "refresh-token", moduleName: "auth");
        final result =
            await _httpClient.post(url, data: {"token": refreshToken});
        final model = AuthCredentialsModel.fromJson(result.data);

        await _preferences.setUserRefreshToken(model.refreshToken);
        await _preferences.setUserAccessToken(model.accessToken);

        return ResultWrapper<AuthCredentialsEntity>.success(model);
      }
      final model = AuthCredentialsModel(
        accessToken: _preferences.getUserAccessToken()!,
        refreshToken: _preferences.getUserRefreshToken()!,
        userId: _preferences.getUserId()!,
      );
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
