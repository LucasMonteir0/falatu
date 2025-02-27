import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/create_chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/repositories/chat/chat_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/create_chat/create_chat_use_case.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

class CreateChatUseCaseImpl implements CreateChatUseCase {
  final ChatRepository _repository;

  CreateChatUseCaseImpl(this._repository);
  @override
  ResultWrapper<Stream<ChatEntity>> call(CreateChatEntity params) {
    return _repository.createChat(params);
  }
}
