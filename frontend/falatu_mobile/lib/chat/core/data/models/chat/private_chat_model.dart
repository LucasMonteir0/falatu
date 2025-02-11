import "package:falatu_mobile/chat/core/data/models/chat/chat_model.dart";
import "package:falatu_mobile/chat/core/data/models/chat/chat_user_model.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";

class PrivateChatModel extends ChatModel {
  final ChatUserModel otherUser;

  PrivateChatModel({
    required super.id,
    required super.type,
    required super.createdAt,
    required super.users,
    required this.otherUser,
  });

  factory PrivateChatModel.fromJson(
      Map<String, dynamic> json, ChatUserModel otherUser) {
    final users = (json["users"] as List<dynamic>)
        .map((e) => ChatUserModel.fromJson(e))
        .toList();
    return PrivateChatModel(
      id: json["id"],
      type: ChatType.fromValue(json["type"]),
      createdAt: DateTime.parse(json["createdAt"]),
      users: users,
      otherUser: otherUser,
    );
  }
}
