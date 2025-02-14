import "package:falatu_mobile/chat/core/data/models/chat/chat_model.dart";
import "package:falatu_mobile/chat/core/data/models/chat/chat_user_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/group_chat_entity.dart";

class GroupChatModel extends ChatModel {
  final String title;
  final String? pictureUrl;

  const GroupChatModel({
    required super.id,
    required super.type,
    required super.createdAt,
    required super.users,
    required this.title,
    this.pictureUrl,
  });

  factory GroupChatModel.fromJson(Map<String, dynamic> json) {
    final users = (json["users"] as List<dynamic>)
        .map((e) => ChatUserModel.fromJson(e))
        .toList();
    return GroupChatModel(
      id: json["id"],
      type: json["type"],
      createdAt: json["createdAt"],
      users: users,
      title: json["title"],
      pictureUrl: json["pictureUrl"],
    );
  }

  @override
  GroupChatEntity toEntity() {
    return GroupChatEntity(
      id: id,
      type: type,
      createdAt: createdAt,
      users: users,
      title: title,
    );
  }
}
