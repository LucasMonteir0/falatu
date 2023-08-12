import 'package:falatu/app/core/data/datasources/remote/chat/chat_datasource.dart';
import 'package:falatu/app/core/data/models/chat_model.dart';
import 'package:falatu/app/core/domains/repositories/chat/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource datasource;

  ChatRepositoryImpl(this.datasource);

  @override
  Stream<List<ChatModel>> getPrivateChats(String userId) {
    return datasource.getPrivateChats(userId);
  }
}
