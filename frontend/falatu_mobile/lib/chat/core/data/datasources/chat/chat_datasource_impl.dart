import "dart:async";
import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource.dart";
import "package:falatu_mobile/chat/core/data/models/chat/chat_model.dart";
import "package:falatu_mobile/chat/core/data/models/chat/create_chat_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";
import "package:falatu_mobile/commons/core/domain/entities/base_error.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/services/socket_io_service/socket_io_service.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";

class ChatDatasourceImpl implements ChatDatasource {
  final SharedPreferencesService _preferences;
  final SocketIoService _socket;
  late final String? _userId;

  ChatDatasourceImpl(this._preferences, this._socket) {
    _userId = _preferences.getUserId();
  }

  final StreamController<List<ChatEntity>> _controller =
      StreamController.broadcast();

  final StreamController<ChatEntity> _createdChatStream =
      StreamController.broadcast();

  Future<BaseError?> _connect() async {
    final String url = UrlHelpers.getChatsSocketUrl();
    BaseError? error;
    await _socket.connect(
      url,
      query: {"userId": _userId},
      onError: (value) {
        error = value;
      },
    );
    return error;
  }

  @override
  Future<ResultWrapper<Stream<List<ChatEntity>>>> loadChats() async {
    BaseError? connectionError = await _connect();

    if (connectionError != null) {
      return ResultWrapper.error(connectionError);
    }
    _socket.on("chats", (data) {
      _controller.add((data as List<dynamic>)
          .map((e) => ChatModel.fromJson(e, _extractOtherUser(e)).toEntity())
          .toList());
    });

    return ResultWrapper.success(_controller.stream);
  }

  @override
  ResultWrapper<Stream<ChatEntity>> createChat(CreateChatModel params) {
    try {
      _socket.emit("create", params.toJson());
      _socket.on(
        "createdChat",
        (e) {
          _createdChatStream
              .add(ChatModel.fromJson(e, _extractOtherUser(e)).toEntity());
        },
      );
      return ResultWrapper.success(_createdChatStream.stream);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }

  Map<String, dynamic> _extractOtherUser(Map<String, dynamic> json) {
    if (json["type"] == ChatType.private.name) {
      return (json["users"] as List<dynamic>)
          .firstWhere((e) => e["id"] != _userId);
    }
    return {};
  }
}
