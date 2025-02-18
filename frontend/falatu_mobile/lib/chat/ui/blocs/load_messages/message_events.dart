import "package:equatable/equatable.dart";

abstract class MessageEvents extends Equatable {}

class LoadMessages extends MessageEvents {
  final String chatId;

  LoadMessages(this.chatId);

  @override
  List<Object?> get props => [chatId];
}
