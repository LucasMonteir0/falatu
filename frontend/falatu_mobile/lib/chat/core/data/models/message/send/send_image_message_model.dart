import "package:falatu_mobile/chat/core/data/models/message/send/send_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_image_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendImageMessageModel extends SendMessageModel {
  const SendImageMessageModel({
    required super.senderId,
    required super.mediaFile,
    super.text,
    super.type = MessageType.image,
  });

  factory SendImageMessageModel.fromObject(SendImageMessageEntity object) =>
      SendImageMessageModel(
        senderId: object.senderId,
        mediaFile: object.mediaFile,
        text: object.text,
      );

  @override
  Map<String, dynamic> toJson() => {
        "type": type.name,
        "senderId": senderId,
        if (text != null) "text": text,
      };
}
