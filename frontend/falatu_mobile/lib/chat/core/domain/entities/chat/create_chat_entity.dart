import "package:equatable/equatable.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";

class CreateChatEntity extends Equatable {
  final ChatType type;
  final List<String> usersIds;

  const CreateChatEntity({required this.type, required this.usersIds});

  @override
  List<Object?> get props => [type, usersIds];
}