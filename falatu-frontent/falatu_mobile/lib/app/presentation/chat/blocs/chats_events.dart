import 'package:equatable/equatable.dart';

abstract class ChatEvents extends Equatable {}

class LoadPrivateChats extends ChatEvents{

  final String userId;

  LoadPrivateChats(this.userId);

  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class LoadGroupChats extends ChatEvents {
  final String userId;

  LoadGroupChats(this.userId);

  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}
