import "package:dio/dio.dart";
import "package:falatu_mobile/commons/core/data/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:flutter/foundation.dart";
import "package:jwt_decoder/jwt_decoder.dart";

class HttpServiceImpl extends HttpService {
  final Dio _dio;
  final SharedPreferencesService preferences;
  final Future<void> Function()? onRefreshToken;
  final Future<void> Function()? onSignOut;

  HttpServiceImpl(this._dio, this.preferences,
      {this.onRefreshToken, this.onSignOut}) {
    _setupLogging();
    _setupInterceptors();
  }

  void _setupLogging() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print("REQUEST[${options.method}] => PATH: ${options.path}");
            print("REQUEST[${options.method}] => BODY: ${options.data}");
            print(
                "REQUEST[${options.method}] => QUERY: ${options.queryParameters}");
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          }
          handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print(
                "ERROR[${e.response?.statusCode}] => MESSAGE: ${e.response?.data}");
          }
          handler.next(e);
        },
      ),
    );
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? access = preferences.getUserAccessToken();
          String? refresh = preferences.getUserRefreshToken();
          if (access != null && access.isNotEmpty) {

            //Verifica se o access token está expirado.
            if (JwtDecoder.isExpired(access) && !options.path.contains("refresh-token")) {

              //Se o refresh estiver expirado, então deslogará o usuário.
              if (refresh != null &&
                  JwtDecoder.isExpired(refresh) &&
                  onSignOut != null) {
                await onSignOut!();
              }

              // Se o access estiver expirado ele acessa recupera outro access pelo refresh.
              if (onRefreshToken != null) {
                await onRefreshToken!();
                access = preferences.getUserAccessToken();
              }
            }
            options.headers["Authorization"] = "Bearer $access";
          }

          return handler.next(options);
        },
        onResponse: (options, handler) async {
          return handler.next(options);
        },
      ),
    );
  }

  Future<ApiResponse<T>> _request<T>(Future<Response<T>> futureRequest) async {
    try {
      Response<T> response = await futureRequest;
      return ApiResponse.fromDioResponse(response);
    } catch (e) {
      if (e is DioException) {
        throw ApiError.fromDioException(e);
      } else {
        throw ApiError(
          message: e.toString(),
          errorType: DioExceptionType.unknown,
        );
      }
    }
  }

  @override
  Future<ApiResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return await _request<T>(_dio.get(path, queryParameters: queryParameters));
  }

  @override
  Future<ApiResponse<T>> post<T>(String path, {dynamic data}) async {
    return await _request<T>(_dio.post(path, data: data));
  }

  @override
  Future<ApiResponse<T>> put<T>(String path, {dynamic data}) async {
    return await _request<T>(_dio.put(path, data: data));
  }

  @override
  Future<ApiResponse<T>> delete<T>(String path, {dynamic data}) async {
    return await _request<T>(_dio.delete(path, data: data));
  }

  @override
  Future<ApiResponse<T>> patch<T>(String path, {dynamic data}) async {
    return await _request<T>(_dio.patch(path, data: data));
  }
}
