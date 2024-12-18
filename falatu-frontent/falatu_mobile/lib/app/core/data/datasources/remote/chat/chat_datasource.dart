import 'dart:io';

import 'package:falatu/app/core/data/models/chat/chat_model.dart';
import 'package:falatu/app/core/data/models/messages/message_model.dart';

abstract class ChatDatasource{

  Stream<List<ChatModel>> getPrivateChats(String userId);
  Stream<List<MessageModel>> getChatMessages(String chatId);
  Future<void> sendChatMessage(ChatModel chat, MessageModel message);
  Future<String?> uploadChatFile(File file, String chatId);

}