import "package:falatu_mobile/chat/core/data/models/chat/chat_model.dart";
import "package:falatu_mobile/chat/core/data/models/chat/chat_user_model.dart";
import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/private_chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";

class PrivateChatModel extends ChatModel {
  final ChatUserModel otherUser;

  const PrivateChatModel({
    required super.id,
    required super.type,
    required super.createdAt,
    required super.users,
    required super.lastMessage,
    required this.otherUser,
    required super.unreadCount,
  });

  factory PrivateChatModel.fromJson(
      Map<String, dynamic> json, ChatUserModel otherUser) {
    final users = (json["users"] as List<dynamic>)
        .map((e) => ChatUserModel.fromJson(e))
        .toList();

    final MessageEntity? lastMessage =
        (json["lastMessage"] as Map<String, dynamic>?)
            .let((j) => MessageModel.fromJson(json["lastMessage"]).toEntity());

    return PrivateChatModel(
      id: json["id"],
      type: ChatType.fromValue(json["type"]),
      createdAt: DateTime.parse(json["createdAt"]),
      users: users,
      otherUser: otherUser,
      lastMessage: lastMessage,
      unreadCount: json["unreadCount"],
    );
  }

  @override
  PrivateChatEntity toEntity() {
    return PrivateChatEntity(
      id: id,
      type: type,
      createdAt: createdAt,
      users: users,
      otherUser: otherUser,
      lastMessage: lastMessage,
      unreadCount: unreadCount,
    );
  }
}
