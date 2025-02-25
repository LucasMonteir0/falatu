import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/repositories/chat/chat_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/load_chats/load_chats_use_case.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

class LoadChatsUseCaseImpl implements LoadChatsUseCase {
  final ChatRepository _repository;

  LoadChatsUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<Stream<List<ChatEntity>>>> call() {
    return _repository.loadChats();
  }
}
