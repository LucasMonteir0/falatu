import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:intl/intl.dart';

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

  factory MessageModel.fromMap(Map<String, dynamic> e) {
    final String time = DateFormat.Hm().format(e['timestamp'].toDate());
    final List<String> viewed = e['viewed'].toList().cast<String>();

    return MessageModel(
      message: e['message'],
      senderId: e['senderId'],
      timestamp: time,
      type: e['type'],
      viewed: viewed,
      extension: e['extension'],
      documentUrl: e['documentUrl'],
      size: e['size'],
    );
  }
}
