import "dart:async";
import "dart:io";

import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource.dart";
import "package:falatu_mobile/chat/core/data/models/chat/chat_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/data/services/socket_io_service/socket_io_service.dart";
import "package:falatu_mobile/commons/core/domain/entities/base_error.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";
import "package:flutter/cupertino.dart";

class ChatDatasourceImpl extends ChatDatasource {
  final SharedPreferencesService _preferences;
  final SocketIoService _socket;
  late final String? _userId;
  late BaseError? _connectionError;

  ChatDatasourceImpl(this._preferences, this._socket) {
    _userId = _preferences.getUserId();
    _connectionError = _connect();
  }

  final StreamController<List<ChatEntity>> _controller =
      StreamController.broadcast();

  BaseError? _connect() {
    final String url = UrlHelpers.getChatsSocketUrl();
    BaseError? error;
    _socket.connect(
      url,
      query: {"userId": _userId},
      onError: (value) {
        error = value;
      },
    );
    return error;
  }

  @override
  void dispose() {
    _controller.close();
    _socket.disconnect();
    _socket.dispose();
  }

  @override
  ResultWrapper<Stream<List<ChatEntity>>> loadChats() {
    _socket.on("chats", (data) {
      _controller.add((data as List<dynamic>)
          .map((e) => ChatModel.fromJson(e, _extractOtherUser(e)).toEntity())
          .toList());
    });
    if (_connectionError != null) {
      return ResultWrapper.error(_connectionError);
    }
    return ResultWrapper.success(_controller.stream);
  }

  @override
  Future<ResultWrapper<ChatEntity>> create() {
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
