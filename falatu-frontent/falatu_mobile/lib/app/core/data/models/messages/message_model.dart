import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/app/core/data/models/messages/message_viewers_model.dart';
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
    final List<MessageViewersModel> viewedList = map['viewed']
        .map<MessageViewersModel>((e) => MessageViewersModel.fromMap(e))
        .toList();
    return MessageModel(
      message: map['message'],
      senderId: map['senderId'],
      timestamp: time,
      type: map['type'],
      viewed: viewedList,
      extension: map['extension'],
      documentUrl: map['documentUrl'],
      size: map['size'],
    );
  }

  Map<String, dynamic> toMap() {
    final List<Map<String, dynamic>> viewedList = viewed.map<Map<String, dynamic>>((e) {
      final data = MessageViewersModel.fromEntity(e);
      return data.toMap();
    } ).toList();

    return {
      'message': message,
      'senderId': senderId,
      'timestamp': Timestamp.fromDate(timestamp),
      'type': type,
      'viewed': viewedList,
      'extension': extension,
      'documentUrl': documentUrl,
      'size': size,
    };
  }
}
