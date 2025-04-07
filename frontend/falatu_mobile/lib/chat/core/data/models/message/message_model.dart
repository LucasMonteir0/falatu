import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/data/models/message/audio_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/file_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/image_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/text_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/video_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class MessageModel extends MessageEntity {
  const MessageModel(
      {required super.id,
      required super.sender,
      required super.type,
      required super.createdAt});

  factory MessageModel.fromJson(Map<String, dynamic> json, {XFile? file}) {
    final type = MessageType.fromValue(json["type"]);

    switch (type) {
      case MessageType.text:
        return TextMessageModel.fromJson(json);
      case MessageType.audio:
        return AudioMessageModel.fromJson(json);
      case MessageType.video:
        return VideoMessageModel.fromJson(json);
      case MessageType.image:
        return ImageMessageModel.fromJson(json);
      case MessageType.file:
        return FileMessageModel.fromJson(json);
    }
  }

  MessageEntity toEntity() {
    switch (type) {
      case MessageType.text:
        return (this as TextMessageModel).toEntity();
      case MessageType.audio:
        return (this as AudioMessageModel).toEntity();
      case MessageType.video:
        return (this as VideoMessageModel).toEntity();
      case MessageType.image:
        return (this as ImageMessageModel).toEntity();
      case MessageType.file:
        return (this as FileMessageModel).toEntity();
    }
  }
}
