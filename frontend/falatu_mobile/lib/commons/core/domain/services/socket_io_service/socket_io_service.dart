import "package:falatu_mobile/commons/core/domain/entities/base_error.dart";
import "package:flutter/material.dart";

abstract class SocketIoService {
  Future<void> connect(String url,
      {Map<String, dynamic>? query,
      Map<String, dynamic>? headers,
      ValueChanged<BaseError?>? onError});

  void disconnect();

  void dispose();

  void on(String event, Function(dynamic) handler);

  void emit(String event, dynamic data);
}
