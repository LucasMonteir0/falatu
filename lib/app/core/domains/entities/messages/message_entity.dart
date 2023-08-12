class MessageEntity {
  final String message;
  final String senderId;
  final String timestamp;
  final String type;
  final List<String> viewed;

  MessageEntity(
      {required this.message,
      required this.senderId,
      required this.timestamp,
      required this.type,
      required this.viewed});
}
