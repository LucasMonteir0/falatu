import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";

class AudioMessageEntity extends MessageEntity {
  final XFile? audio;

  const AudioMessageEntity({
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
    required this.audio,
  });
}
