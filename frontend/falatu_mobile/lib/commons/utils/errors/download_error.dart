import "package:falatu_mobile/commons/core/domain/entities/base_error.dart";
import "package:flutter/foundation.dart";

class DownloadError extends BaseError {
  DownloadError({required super.message}) {
    if (kDebugMode) {
      print(message);
    }
  }

  @override
  List<Object?> get props => [message];
}
