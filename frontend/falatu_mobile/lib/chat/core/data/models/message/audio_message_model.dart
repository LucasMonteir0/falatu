import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/audio_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";

class AudioMessageModel extends MessageModel {
  final String mediaUrl;

  const AudioMessageModel({
    required this.mediaUrl,
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
  });

  factory AudioMessageModel.fromJson(Map<String, dynamic> json) {
    final createdAt = DateTime.parse(json["createdAt"]).toLocal();
    return AudioMessageModel(
      id: json["id"],
      sender: UserModel.fromJson(json["sender"]),
      type: MessageType.fromValue(json["type"]),
      createdAt: createdAt,
      mediaUrl: json["mediaUrl"],
    );
  }

  @override
  AudioMessageEntity toEntity() => AudioMessageEntity(
        id: id,
        sender: sender,
        type: type,
        createdAt: createdAt,
        mediaUrl: mediaUrl,
      );
}
