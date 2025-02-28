import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_user_entity.dart";

class PrivateChatEntity extends ChatEntity {
  final ChatUserEntity otherUser;

  const PrivateChatEntity({
    required super.id,
    required super.type,
    required super.createdAt,
    required super.users,
    required this.otherUser,
    required super.unreadCount,
    required super.lastMessage,
  });
}
