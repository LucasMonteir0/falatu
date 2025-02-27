import "package:equatable/equatable.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";

abstract class CreateChatEvents extends Equatable{}


class Create extends CreateChatEvents{
  final ChatType type;
  final List<String> usersIds;

  Create({required this.type, required this.usersIds});
  @override
  List<Object?> get props => [type, usersIds];
}