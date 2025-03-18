import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/audio_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";

class AudioMessageModel extends MessageModel {
  final XFile? audio;

  const AudioMessageModel({
    required this.audio,
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
  });

  factory AudioMessageModel.fromJson(Map<String, dynamic> json, XFile? file) {
    final createdAt = DateTime.parse(json["createdAt"]).toLocal();
    return AudioMessageModel(
      id: json["id"],
      audio: file,
      sender: UserModel.fromJson(json["sender"]),
      type: MessageType.fromValue(json["type"]),
      createdAt: createdAt,
    );
  }

  @override
  AudioMessageEntity toEntity() => AudioMessageEntity(
        id: id,
        sender: sender,
        type: type,
        createdAt: createdAt,
        audio: audio,
      );
}
