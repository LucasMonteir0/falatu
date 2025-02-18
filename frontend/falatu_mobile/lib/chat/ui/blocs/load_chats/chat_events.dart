import "package:equatable/equatable.dart";

abstract class ChatEvents extends Equatable{}


class LoadChats extends ChatEvents{
  @override
  List<Object?> get props => [];
}