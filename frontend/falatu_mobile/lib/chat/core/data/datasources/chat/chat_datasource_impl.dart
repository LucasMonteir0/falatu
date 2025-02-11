import "dart:async";
import "dart:io";
import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource.dart";
import "package:falatu_mobile/chat/core/data/models/chat/chat_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";
import "package:falatu_mobile/commons/core/domain/entities/base_error.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:flutter/cupertino.dart";
import "package:socket_io_client/socket_io_client.dart" as io;

class ChatDatasourceImpl extends ChatDatasource {
  final SharedPreferencesService _preferences;
  late final String? _userId;

  ChatDatasourceImpl(this._preferences) {
    _userId = _preferences.getUserId();
  }

  late io.Socket _socket;
  final StreamController<List<ChatEntity>> _controller =
      StreamController.broadcast();

  void _connect({ValueChanged<BaseError?>? onError}) {
    final accessToken = _preferences.getUserAccessToken();

    _socket = io.io(
      "http://localhost:80/chats",
      io.OptionBuilder().setTransports(["websocket"]).setExtraHeaders(
          {"authorization": accessToken}).setQuery({"userId": _userId}).build(),
    );

    _socket.on("chats", (data) {
      _controller.add((data as List<dynamic>)
          .map((e) => ChatModel.fromJson(e, _extractOtherUser(e)))
          .toList());
    });

    _socket.onError(
      (data) {
        if (data is SocketException && data.osError?.errorCode == 61) {
          onError?.call(ServiceUnavailableError());
        }
        onError?.call(null);
      },
    );

    _socket.connect();
  }

  @override
  void dispose() {
    _controller.close();
    _socket.dispose();
  }

  @override
  ApiResult<Stream<List<ChatEntity>>> loadChats() {
    BaseError? error;
    _connect(
      onError: (value) {
        error = value;
      },
    );

    if (error != null) {
      return ApiResult.error(error);
    }
    return ApiResult.success(_controller.stream);
  }

  @override
  Future<ApiResult<ChatEntity>> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  Map<String, dynamic> _extractOtherUser(Map<String, dynamic> json) {
    if (json["type"] == ChatType.private.name) {
      return (json["users"] as List<dynamic>)
          .firstWhere((e) => e["id"] != _userId);
    }
    return {};
  }
}
