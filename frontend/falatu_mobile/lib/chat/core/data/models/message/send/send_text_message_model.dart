import "package:falatu_mobile/chat/core/data/models/message/send/send_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_text_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendTextMessageModel extends SendMessageModel {
  const SendTextMessageModel({
    required super.senderId,
    required super.text,
    super.type = MessageType.text,
  });

  factory SendTextMessageModel.fromObject(SendTextMessageEntity object) =>
      SendTextMessageModel(
        senderId: object.senderId,
        text: object.text,
      );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.name,
    "senderId": senderId,
    "text": text,
  };
}
