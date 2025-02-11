import "base_error.dart";

class ResultWrapper<T> {
  final bool success;
  final T? data;
  final BaseError? error;

  ResultWrapper({required this.success, this.data, this.error});

  factory ResultWrapper.success(T data) {
    return ResultWrapper(success: data != null, data: data);
  }

  factory ResultWrapper.error(BaseError? error) {
    return ResultWrapper(success: false, error: error);
  }
}
