import "package:falatu_mobile/chat/core/data/models/message/send/send_audio_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/send/send_file_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/send/send_image_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/send/send_text_message_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/send/send_video_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_audio_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_file_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_image_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_text_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_video_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendMessageModel extends SendMessageEntity {
  const SendMessageModel(
      {required super.senderId,
      required super.type,
      super.mediaFile,
      super.text});

  factory SendMessageModel.fromObject(SendMessageEntity object) {
    switch (object.type) {
      case MessageType.text:
        return SendTextMessageModel.fromObject(object as SendTextMessageEntity);
      case MessageType.audio:
        return SendAudioMessageModel.fromObject(
            object as SendAudioMessageEntity);
      case MessageType.video:
        return SendVideoMessageModel.fromObject(
            object as SendVideoMessageEntity);
      case MessageType.image:
        return SendImageMessageModel.fromObject(
            object as SendImageMessageEntity);
      case MessageType.file:
        return SendFileMessageModel.fromObject(object as SendFileMessageEntity);
    }
  }

  Map<String, dynamic> toJson() {
    switch (type) {
      case MessageType.text:
        return (this as SendTextMessageModel).toJson();
      case MessageType.audio:
        return (this as SendAudioMessageModel).toJson();
      case MessageType.video:
        return (this as SendVideoMessageModel).toJson();
      case MessageType.image:
        return (this as SendImageMessageModel).toJson();
      case MessageType.file:
        return (this as SendFileMessageModel).toJson();
    }
  }
}
