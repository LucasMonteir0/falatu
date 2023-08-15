class MessageEntity {
  final String message;
  final String senderId;
  final DateTime timestamp;
  final String type;
  final List<String> viewed;
  final String? extension;
  final String? documentUrl;
  final String? size;

  MessageEntity({
    required this.message,
    required this.senderId,
    required this.timestamp,
    required this.type,
    required this.viewed,
    this.extension,
    this.documentUrl,
    this.size,
  });
}
