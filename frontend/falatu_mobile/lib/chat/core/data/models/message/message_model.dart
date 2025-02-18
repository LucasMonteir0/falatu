import "package:falatu_mobile/chat/core/data/models/message/text_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class MessageModel extends MessageEntity {
  const MessageModel(
      {required super.id,
      required super.sender,
      required super.type,
      required super.createdAt});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final type = MessageType.fromValue(json["type"]);

    switch (type) {
      case MessageType.text:
        return TextMessageModel.fromJson(json);
      case MessageType.audio:
        throw UnimplementedError();
      case MessageType.video:
        // TODO: Handle this case.
        throw UnimplementedError();
      case MessageType.image:
        // TODO: Handle this case.
        throw UnimplementedError();
      case MessageType.file:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  MessageEntity toEntity() {
    switch (type) {
      case MessageType.text:
        return (this as TextMessageModel).toEntity();
      case MessageType.audio:
        throw UnimplementedError();
      case MessageType.video:
        // TODO: Handle this case.
        throw UnimplementedError();
      case MessageType.image:
        // TODO: Handle this case.
        throw UnimplementedError();
      case MessageType.file:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
