import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";

class PrivateChatEntity extends ChatEntity {
  PrivateChatEntity(
      {required super.id,
      required super.type,
      required super.createdAt,
      required super.users});
}
