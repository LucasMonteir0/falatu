import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/repositories/chat/chat_repository.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";

class ChatRepositoryImpl implements ChatRepository {
  late final ChatDatasource _datasource;

  @override
  Future<ApiResult<ChatEntity>> create() {
    return _datasource.create();
  }

  @override
  ApiResult<Stream<List<ChatEntity>>> loadChats() {
    return _datasource.loadChats();
  }
}
