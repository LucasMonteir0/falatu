import "dart:io";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/data/services/socket_io_service/socket_io_service.dart";
import "package:falatu_mobile/commons/core/domain/entities/base_error.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:flutter/material.dart";
import "package:jwt_decoder/jwt_decoder.dart";
import "package:socket_io_client/socket_io_client.dart" as io;

class SocketServiceIoImpl implements SocketIoService {
  final Future<void> Function()? _onRefreshToken;
  final Future<void> Function()? _onSignOut;
  final SharedPreferencesService _preferences;
  io.Socket? _socket;

  SocketServiceIoImpl({
    required Future<void> Function()? onRefreshToken,
    required Future<void> Function()? onSignOut,
    required SharedPreferencesService preferences,
  })  : _onRefreshToken = onRefreshToken,
        _onSignOut = onSignOut,
        _preferences = preferences;

  @override
  Future<void> connect(String url,
      {Map<String, dynamic>? query,
      Map<String, dynamic>? headers,
      ValueChanged<BaseError?>? onError}) async {
    //
    // if (access != null && access.isNotEmpty && JwtDecoder.isExpired(access)) {
    //   if (refresh != null && JwtDecoder.isExpired(refresh)) {
    //     await _onSignOut?.call();
    //     return;
    //   }
    //   await _onRefreshToken?.call();
    //   access = _preferences.getUserAccessToken();
    // }

    String? access = _preferences.getUserAccessToken();

    _socket = io.io(
      url,
      io.OptionBuilder()
          .setTransports(["websocket"])
          .setReconnectionDelay(5000)
          .disableAutoConnect()
          .setExtraHeaders(
              {"authorization": access!, if (headers != null) ...headers})
          .setQuery(query ?? {})
          .build(),
    );

    _socket?.onConnect((_) async {
      _socket?.io.options?["extraHeaders"] = {"authorization": access};
    });

    _socket?.onError((data) {
      if (data is SocketException && data.osError?.errorCode == 61) {
        onError?.call(ServiceUnavailableError());
      }
      onError?.call(UnknownError(message: data.toString()));
    });
    _socket?.connect();
  }

  @override
  void disconnect() {
    if (_socket == null) {
      throw UnknownError(message: "Socket not initialized.");
    }
    _socket?.disconnect();
  }

  @override
  void dispose() {
    _socket?.dispose();
  }

  @override
  void on(String event, Function(dynamic data) handler) {
    if (_socket == null) {
      throw UnknownError(message: "Socket not initialized.");
    }
    _socket?.on(event, handler);
  }

  @override
  void emit(String event, [dynamic data]) {
    if (_socket == null) {
      throw UnknownError(message: "Socket not initialized.");
    }
    _socket?.emit(event, data);
  }
}
