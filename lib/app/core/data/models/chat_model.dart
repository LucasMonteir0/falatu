import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:intl/intl.dart';

class ChatModel extends ChatEntity {
  ChatModel(
      {required super.id,
      required super.lastMessage,
      required super.lastMessageTime,
      required super.users,
      required super.type});

  factory ChatModel.fromMap(Map<String, dynamic> e) {
    final String time = DateFormat.Hm().format(e['lastMessageTime'].toDate());
    final List<String> users = e['users'].toList().cast<String>();

    return ChatModel(
        id: e['id'],
        lastMessage: e['lastMessage'],
        lastMessageTime: time,
        users: users,
        type: e['type']);
  }
}
