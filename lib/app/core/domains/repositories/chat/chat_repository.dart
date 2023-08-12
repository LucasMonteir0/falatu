import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';

abstract class ChatRepository {
  Stream<List<ChatEntity>> getPrivateChats(String userId);
}