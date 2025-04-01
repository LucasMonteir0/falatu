import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";

class AudioMessageEntity extends MessageEntity {
  final String mediaUrl;

  const AudioMessageEntity({
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
    required this.mediaUrl,
  });
}
