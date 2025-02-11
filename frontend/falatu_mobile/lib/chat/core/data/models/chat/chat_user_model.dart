import "package:falatu_mobile/chat/core/domain/entities/chat/chat_user_entity.dart";
import "package:falatu_mobile/chat/utils/enums/chat_role.dart";

class ChatUserModel extends ChatUserEntity {
  const ChatUserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.pictureUrl,
      required super.createdAt,
      required super.role});

  factory ChatUserModel.fromJson(Map<String, dynamic> json) => ChatUserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      pictureUrl: json["pictureUrl"],
      createdAt: DateTime.parse(json["createdAt"]),
      role: ChatRole.fromValue(json["role"]),
    );
}
