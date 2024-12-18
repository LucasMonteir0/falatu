import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';

class ChatFilter {
  static List<ChatEntity> chatsWithMessages(List<ChatEntity> chatList) {
    return chatList.where((chat) => chat.lastMessageTime != null).toList();
}

}
