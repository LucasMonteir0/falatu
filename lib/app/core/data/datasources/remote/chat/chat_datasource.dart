import 'package:falatu/app/core/data/models/chat_model.dart';
import 'package:falatu/app/core/data/models/message_model.dart';

abstract class ChatDatasource{

  Stream<List<ChatModel>> getPrivateChats(String userId);
  Stream<List<MessageModel>> getChatMessages(String chatId);

}