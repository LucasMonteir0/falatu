import 'package:equatable/equatable.dart';

abstract class MessagesEvent extends Equatable{}

class LoadMessages extends MessagesEvent{
  final String chatId;

  LoadMessages(this.chatId);

  @override
  List<Object?> get props => [chatId];

}