import "dart:async";
import "package:cross_file/cross_file.dart";
import "package:dio/dio.dart";
import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource.dart";
import "package:falatu_mobile/chat/core/data/models/message/audio_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/file_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/send/send_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/domain/entities/base_error.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/services/file_service/file_service.dart";
import "package:falatu_mobile/commons/core/domain/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/services/socket_io_service/socket_io_service.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/errors/handle_error.dart";
import "package:falatu_mobile/commons/utils/helpers/http_send_file_helper.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";

class MessagesDatasourceImpl implements MessagesDatasource {
  final SharedPreferencesService _preferences;
  final SocketIoService _socket;
  final HttpService _http;
  final FileService _file;
  late final String? _userId;

  MessagesDatasourceImpl(
      this._preferences, this._socket, this._http, this._file) {
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

    _socket.on("messages", (data) async {
      List<Future<MessageEntity>> futures =
          (data as List<dynamic>).map((e) async {
        if (e["type"] == MessageType.file.name) {
          final file = await _file.fileFromUrl(e["mediaUrl"]);
          return FileMessageModel.fromJson(e, file).toEntity();
        }
        if (e["type"] == MessageType.audio.name) {
          final file = await _file.fileFromUrl(e["mediaUrl"]);
          return AudioMessageModel.fromJson(e, file).toEntity();
        }
        return MessageModel.fromJson(e).toEntity();
      }).toList();

      _controller.add(await Future.wait(futures));
    });
    return ResultWrapper.success(_controller.stream);
  }

  @override
  void sendMessage(String chatId, SendMessageEntity message) async {
    final model = SendMessageModel.fromObject(message);

    if (model.mediaFile != null) {
      final url =
          await uploadMessageFile(chatId, model.mediaFile!, message.type);
      if (url.success) {
        final json = {...model.toJson(), "mediaUrl": url.data!};
        _socket.emit("sendMessage", {"chatId": chatId, "message": json});
        return;
      }
      return;
    }

    _socket.emit("sendMessage", {"chatId": chatId, "message": model.toJson()});
  }

  @override
  void addOldMessages(String chatId, int page) async {
    _socket.emit("addOldMessages", {"chatId": chatId, "page": page});
  }

  @override
  Future<ResultWrapper<String>> uploadMessageFile(
      String chatId, XFile file, MessageType type) async {
    try {
      final url =
          UrlHelpers.getApiBaseUrl(moduleName: "messages", path: "upload-file");

      final multipartFile = await HttpSendFilesHelper.fromFile(file);
      final formData = FormData.fromMap({
        "chatId": chatId,
        "type": type.name,
        "file": multipartFile,
      });

      final response = await _http.post(url, data: formData);
      return ResultWrapper.success(response.data["url"] as String);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }

  @override
  void leaveChat() {
    _socket.disconnect();
  }
}
