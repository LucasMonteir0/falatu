import 'package:falatu/app/core/data/models/chat_model.dart';

abstract class ChatDatasource{

  Stream<List<ChatModel>> getPrivateChats(String userId);

}