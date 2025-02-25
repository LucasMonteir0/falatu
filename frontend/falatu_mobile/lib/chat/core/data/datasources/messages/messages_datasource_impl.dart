import "dart:async";

import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource.dart";
import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/send_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";
import "package:falatu_mobile/commons/core/data/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/data/services/socket_io_service/socket_io_service.dart";
import "package:falatu_mobile/commons/core/domain/entities/base_error.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/errors/handle_error.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";

class MessagesDatasourceImpl implements MessagesDatasource {
  final SharedPreferencesService _preferences;
  final SocketIoService _socket;
  final HttpService _client;
  late final String? _userId;

  MessagesDatasourceImpl(this._preferences, this._socket, this._client) {
    _userId = _preferences.getUserId();
  }

  final StreamController<List<MessageEntity>> _controller =
      StreamController.broadcast();

  Future<BaseError?> _connect(String chatId) async {
    final String url = UrlHelpers.getMessagesSocketUrl();

    BaseError? error;
    await _socket.connect(
      url,
      query: {"userId": _userId, "chatId": chatId},
      onError: (value) {
        error = value;
      },
    );
    return error;
  }

  @override
  Future<ResultWrapper<Stream<List<MessageEntity>>>> loadMessages(
      String chatId) async {
    BaseError? connectionError = await _connect(chatId);

    if (connectionError != null) {
      return ResultWrapper.error(connectionError);
    }

    _socket.on("messages", (data) {
      _controller.add((data as List<dynamic>)
          .map((e) => MessageModel.fromJson(e).toEntity())
          .toList());
    });
    return ResultWrapper.success(_controller.stream);
  }

  @override
  void sendMessage(String chatId, SendMessageEntity message) {
    final model = SendMessageModel.fromObject(message);
    _socket.emit("sendMessage", {"chatId": chatId, "message": model.toJson()});
  }

  @override
  void addOldMessages(String chatId, int page) async {
    _socket.emit("addOldMessages", {"chatId": chatId, "page": page});
  }
}
