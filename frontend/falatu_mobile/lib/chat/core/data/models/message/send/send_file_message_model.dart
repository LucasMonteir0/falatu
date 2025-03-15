import "package:falatu_mobile/chat/core/data/models/message/send/send_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_file_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendFileMessageModel extends SendMessageModel {
  const SendFileMessageModel({
    required super.senderId,
    required super.mediaFile,
    super.type = MessageType.file,
  });

  factory SendFileMessageModel.fromObject(SendFileMessageEntity object) =>
      SendFileMessageModel(
        senderId: object.senderId,
        mediaFile: object.mediaFile,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "senderId": senderId,
    };
  }
}
