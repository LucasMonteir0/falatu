import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";

class TextMessageEntity extends MessageEntity {
  final String text;

  const TextMessageEntity({
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
    required this.text,
  });
}
