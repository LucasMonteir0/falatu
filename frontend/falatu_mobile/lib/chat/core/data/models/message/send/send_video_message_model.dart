import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/data/models/message/send/send_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_video_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendVideoMessageModel extends SendMessageModel {
  final XFile thumbFile;

  const SendVideoMessageModel({
    required super.senderId,
    required super.mediaFile,
    required this.thumbFile,
    super.text,
    super.type = MessageType.video,
  });

  factory SendVideoMessageModel.fromObject(SendVideoMessageEntity object) =>
      SendVideoMessageModel(
        senderId: object.senderId,
        mediaFile: object.mediaFile,
        text: object.text,
        thumbFile: object.thumbFile,
      );

  @override
  Map<String, dynamic> toJson() => {
        "type": type.name,
        "senderId": senderId,
        if (text != null) "text": text,
      };
}
