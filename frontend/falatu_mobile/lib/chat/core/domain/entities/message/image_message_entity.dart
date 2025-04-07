import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";

class ImageMessageEntity extends MessageEntity {
  final String mediaUrl;
  final String? text;

  const ImageMessageEntity({
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
    required this.mediaUrl,
    required this.text,
  });
}
