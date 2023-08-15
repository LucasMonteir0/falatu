import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.message,
    required super.senderId,
    required super.timestamp,
    required super.type,
    required super.viewed,
    super.extension,
    super.documentUrl,
    super.size,
  });

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      message: entity.message,
      senderId: entity.senderId,
      timestamp: entity.timestamp,
      type: entity.type,
      viewed: entity.viewed,
      extension: entity.extension,
      documentUrl: entity.documentUrl,
      size: entity.size,
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    final DateTime time = map['timestamp'].toDate();
    final List<String> viewed = map['viewed'].toList().cast<String>();

    return MessageModel(
      message: map['message'],
      senderId: map['senderId'],
      timestamp: time,
      type: map['type'],
      viewed: viewed,
      extension: map['extension'],
      documentUrl: map['documentUrl'],
      size: map['size'],
    );
  }

  Map<String, dynamic> toMap() => {
        'message': message,
        'senderId': senderId,
        'timestamp': Timestamp.fromDate(timestamp),
        'type': type,
        'viewed': viewed,
        'extension': extension,
        'documentUrl': documentUrl,
        'size': size,
      };
}
