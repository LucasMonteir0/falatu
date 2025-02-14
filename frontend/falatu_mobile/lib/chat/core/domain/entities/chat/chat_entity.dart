import "package:equatable/equatable.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_user_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";

class ChatEntity extends Equatable {
  final String id;
  final ChatType type;
  final DateTime createdAt;
  final List<ChatUserEntity> users;
  final MessageEntity? lastMessage;

  const ChatEntity({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.users,
    this.lastMessage,
  });

  @override
  List<Object?> get props => [id, type, createdAt, users];
}
