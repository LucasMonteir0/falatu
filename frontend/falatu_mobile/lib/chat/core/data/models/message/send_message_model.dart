import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";

class SendMessageModel extends SendMessageEntity {
  const SendMessageModel(
      {required super.senderId,
      required super.type,
      super.mediaFile,
      super.text});

  factory SendMessageModel.fromObject(SendMessageEntity object) =>
      SendMessageModel(
          type: object.type,
          senderId: object.senderId,
          text: object.text,
          mediaFile: object.mediaFile);

  Map<String, dynamic> toJson() => {
        "type": type.name,
        "senderId": senderId,
        "text": text,
        "mediaFile": mediaFile,
      };
}
