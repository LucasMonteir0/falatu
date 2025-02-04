import "package:falatu_mobile/chat/core/data/models/chat/chat_model.dart";
import "package:falatu_mobile/chat/core/data/models/chat/chat_user_model.dart";

class PrivateChatModel extends ChatModel {
  PrivateChatModel(
      {required super.id,
      required super.type,
      required super.createdAt,
      required super.users});

  factory PrivateChatModel.fromJson(Map<String, dynamic> json) {
    final users = (json["users"] as List<dynamic>)
        .map((e) => ChatUserModel.fromJson(e))
        .toList();
    return PrivateChatModel(
      id: json["id"],
      type:  json["type"],
      createdAt:  json["createdAt"],
      users: users,
    );
  }
}
