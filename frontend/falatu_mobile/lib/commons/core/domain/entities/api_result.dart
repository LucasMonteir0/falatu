import "base_error.dart";

class ApiResult<T> {
  final bool success;
  final T? data;
  final BaseError? error;

  ApiResult({required this.success, this.data, this.error});

  factory ApiResult.success(T data) {
    return ApiResult(success: data != null, data: data);
  }

  factory ApiResult.error(BaseError? error) {
    return ApiResult(success: false, error: error);
  }
}
