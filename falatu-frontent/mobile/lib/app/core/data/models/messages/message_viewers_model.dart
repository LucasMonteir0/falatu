import 'package:falatu/app/core/domains/entities/messages/message_viewers_entity.dart';

class MessageViewersModel extends MessageViewersEntity {
  MessageViewersModel({required super.userId, required super.timestamp});

  factory MessageViewersModel.fromEntity(MessageViewersEntity entity) {
    return MessageViewersModel(
      userId: entity.userId,
      timestamp: entity.timestamp,
    );
  }

  factory MessageViewersModel.fromMap(Map<String, dynamic> map) {
    final DateTime time = map['timestamp'].toDate();
    return MessageViewersModel(
      userId: map['userId'],
      timestamp: time,
    );
  }

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'timestamp': timestamp,
      };
}
