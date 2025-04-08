import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";

class VideoMessageEntity extends MessageEntity {
  final String mediaUrl;
  final String thumbUrl;
  final String? text;

  const VideoMessageEntity({
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
    required this.mediaUrl,
    required this.thumbUrl,
    required this.text,
  });
}
