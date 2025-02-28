import "package:falatu_mobile/chat/core/data/models/chat/chat_user_model.dart";
import "package:falatu_mobile/chat/core/data/models/chat/group_chat_model.dart";
import "package:falatu_mobile/chat/core/data/models/chat/private_chat_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.id,
    required super.type,
    required super.createdAt,
    required super.users,
    required super.lastMessage,
    required super.unreadCount,
  });

  factory ChatModel.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> otherUser) {
    final type = ChatType.fromValue(json["type"]);

    switch (type) {
      case ChatType.private:
        return PrivateChatModel.fromJson(
            json, ChatUserModel.fromJson(otherUser));
      case ChatType.group:
        return GroupChatModel.fromJson(json);
    }
  }

  ChatEntity toEntity() {
    switch (type) {
      case ChatType.private:
        return (this as PrivateChatModel).toEntity();
      case ChatType.group:
        return (this as GroupChatModel).toEntity();
    }
  }
}
