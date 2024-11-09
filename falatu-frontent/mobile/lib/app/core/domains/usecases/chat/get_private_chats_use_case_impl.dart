import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/repositories/chat/chat_repository.dart';
import 'package:falatu/app/core/domains/usecases/chat/get_private_chats_use_case.dart';

class GetPrivateChatsUseCaseImpl extends GetPrivateChatsUseCase {
  final ChatRepository _repository;

  GetPrivateChatsUseCaseImpl(this._repository);

  @override
  Stream<List<ChatEntity>> getPrivateChats(String userId) {
    return _repository.getPrivateChats(userId);
  }
}
