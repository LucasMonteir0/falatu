import "package:falatu_mobile/chat/core/data/models/message/send/send_message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_audio_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendAudioMessageModel extends SendMessageModel {
  const SendAudioMessageModel({
    required super.senderId,
    required super.mediaFile,
    super.type = MessageType.audio,
  });

  factory SendAudioMessageModel.fromObject(SendAudioMessageEntity object) =>
      SendAudioMessageModel(
        senderId: object.senderId,
        mediaFile: object.mediaFile,
      );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.name,
    "senderId": senderId,
    "mediaFile": mediaFile,
  };
}