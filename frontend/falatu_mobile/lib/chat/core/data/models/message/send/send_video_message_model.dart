import "package:falatu_mobile/chat/core/data/models/message/send/send_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_video_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendVideoMessageModel extends SendMessageModel {
  const SendVideoMessageModel({
    required super.senderId,
    required super.mediaFile,
    super.text,
    super.type = MessageType.video,
  });

  factory SendVideoMessageModel.fromObject(SendVideoMessageEntity object) =>
      SendVideoMessageModel(
        senderId: object.senderId,
        mediaFile: object.mediaFile,
        text: object.text,
      );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.name,
    "senderId": senderId,
    "mediaFile": mediaFile,
    "text": text,
  };
}
