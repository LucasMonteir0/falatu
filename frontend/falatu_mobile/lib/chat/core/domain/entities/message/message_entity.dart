import "package:equatable/equatable.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";

class MessageEntity extends Equatable {
  final String id;
  final UserEntity sender;
  final MessageType type;
  final DateTime createdAt;

  const MessageEntity(
      {required this.id,
      required this.sender,
      required this.type,
      required this.createdAt});

  @override
  List<Object?> get props => [id, sender, type, createdAt];
}
