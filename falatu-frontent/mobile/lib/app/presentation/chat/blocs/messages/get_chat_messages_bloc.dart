import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/core/domains/usecases/chat/get_chat_messages_use_case.dart';
import 'package:falatu/app/presentation/chat/blocs/messages/messages_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetChatMessagesBloc extends Bloc<MessagesEvent, BaseState> {
  final GetChatMessagesUseCase _useCase;

  GetChatMessagesBloc(this._useCase) : super(EmptyState()) {
    on<LoadMessages>((event, emit) {
      emit(LoadingState());
      final Stream<List<MessageEntity>> messagesStream =
          _useCase.getChatMessages(event.chatId);
      return emit
          .forEach(messagesStream, onData: (data) => SuccessState(data))
          .onError((error, stackTrace) =>
              ErrorState('As mensagens não foram carregadas corretamente'));
    });
  }
}
