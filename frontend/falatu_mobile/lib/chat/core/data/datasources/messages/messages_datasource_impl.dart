import "dart:async";
import "package:cross_file/cross_file.dart";
import "package:dio/dio.dart";
import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource.dart";
import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/send/send_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/send/send_video_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/domain/entities/base_error.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/services/socket_io_service/socket_io_service.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/errors/handle_error.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:falatu_mobile/commons/utils/helpers/http_send_file_helper.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";

class MessagesDatasourceImpl implements MessagesDatasource {
  final SharedPreferencesService _preferences;
  final SocketIoService _socket;
  final HttpService _http;
  late final String? _userId;

  MessagesDatasourceImpl(this._preferences, this._socket, this._http) {
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
  void sendMessage(String chatId, SendMessageEntity message) async {
    final model = SendMessageModel.fromObject(message);

    String? mediaUrl;
    String? thumbUrl;

    if (message.mediaFile != null || model is SendVideoMessageModel) {
      final futures = await Future.wait([
        if (model.mediaFile != null)
          uploadMessageFile(chatId, model.mediaFile!, message.type),
        if (model is SendVideoMessageModel)
          uploadMessageFile(chatId, model.thumbFile, MessageType.image)
      ]);

      mediaUrl = message.mediaFile.let((_) => futures[0].data!);
      thumbUrl = model is SendVideoMessageModel ? futures[1].data : null;
    }

    final json = {
      ...model.toJson(),
      if (mediaUrl != null) "mediaUrl": mediaUrl,
      if (thumbUrl != null) "thumbUrl": thumbUrl
    };
    _socket.emit("sendMessage", {"chatId": chatId, "message": json});
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

  @override
  Future<ResultWrapper<List<MessageEntity>>> getMessages(
      {required String chatId, required int page}) async {
    try {
      final url = UrlHelpers.getApiBaseUrl(moduleName: "messages");

      final response = await _http
          .get(url, queryParameters: {"chatId": chatId, "page": page});
      final data = response.data["data"] as List<dynamic>;
      final messages =
          data.map((e) => MessageModel.fromJson(e).toEntity()).toList();
      return ResultWrapper.success(messages);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }
}
