import "dart:async";

import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource.dart";
import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/send_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:socket_io_client/socket_io_client.dart" as io;

class MessagesDatasourceImpl implements MessagesDatasource {
  final SharedPreferencesService _preferences;
  late final String? _userId;

  MessagesDatasourceImpl(this._preferences) {
    _userId = _preferences.getUserId();
  }

  late io.Socket _socket;
  final StreamController<List<MessageEntity>> _controller =
      StreamController.broadcast();

  void _connect(String chatId) {
    final accessToken = _preferences.getUserAccessToken();
    try {
      _socket = io.io(
        "http://localhost:81/chat/messages",
        io.OptionBuilder().setTransports(["websocket"]).setExtraHeaders({
          "authorization": accessToken
        }).setQuery({"userId": _userId, "chatId": chatId}).build(),
      );

      _socket.on("messages", (data) {
        _controller.add((data as List<dynamic>)
            .map((e) => MessageModel.fromJson(e))
            .toList());
      });

      _socket.connect();
      _socket.onError(
        (data) => print(data),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Stream<List<MessageEntity>> loadMessages(String chatId) {
    _connect(chatId);
    return _controller.stream;
  }

  @override
  void sendMessage(String chatId, SendMessageEntity message) {
    final model = SendMessageModel.fromObject(message);
    _socket.emit("sendMessage", {"chatId": chatId, "message": model.toJson()});
  }

  @override
  void dispose() {}
}
