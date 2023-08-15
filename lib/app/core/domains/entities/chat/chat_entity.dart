
class ChatEntity {
  final String id;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final String type;
  final List<String> users;

 const ChatEntity(
      {required this.id,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.type,
      required this.users});
}
