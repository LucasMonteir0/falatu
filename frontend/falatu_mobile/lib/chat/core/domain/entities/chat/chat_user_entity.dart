import "package:equatable/equatable.dart";
import "package:falatu_mobile/chat/utils/enums/chat_role.dart";

class ChatUserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? pictureUrl;
  final DateTime createdAt;
  final ChatRole role;

  const ChatUserEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.pictureUrl,
      required this.createdAt,
      required this.role});

  @override
  List<Object?> get props => [id, name, pictureUrl, createdAt, role];
}
