import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";

class GroupChatEntity extends ChatEntity {
  final String title;
  final String? pictureUrl;

  const GroupChatEntity({
    required super.id,
    required super.type,
    required super.createdAt,
    required super.users,
    required this.title,
    this.pictureUrl,
  });
}
