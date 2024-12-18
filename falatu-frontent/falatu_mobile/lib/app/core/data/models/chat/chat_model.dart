import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel(
      {required super.id,
      required super.lastMessage,
      required super.lastMessageTime,
      required super.users,
      required super.type});

  factory ChatModel.fromEntity(ChatEntity entity) {
    return ChatModel(
      id: entity.id,
      lastMessage: entity.lastMessage,
      lastMessageTime: entity.lastMessageTime,
      users: entity.users,
      type: entity.type,
    );
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    final DateTime? time =
        map['lastMessageTime'] != null ? map['lastMessageTime']!.toDate() : null;
    final List<String> users = map['users'].toList().cast<String>();
    return ChatModel(
        id: map['id'],
        lastMessage: map['lastMessage'],
        lastMessageTime: time,
        users: users,
        type: map['type']);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'lastMessage': lastMessage,
        'lastMessageTime': Timestamp.fromDate(lastMessageTime!),
        'users': users,
        'type': type,
      };
}
