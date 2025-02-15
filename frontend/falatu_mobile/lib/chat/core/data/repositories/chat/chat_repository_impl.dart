import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/repositories/chat/chat_repository.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource _datasource;

  ChatRepositoryImpl(this._datasource);

  @override
  Future<ResultWrapper<ChatEntity>> create() {
    return _datasource.create();
  }

  @override
  ResultWrapper<Stream<List<ChatEntity>>> loadChats() {
    return _datasource.loadChats();
  }
}
