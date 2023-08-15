import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/usecases/chat/get_private_chats_use_case.dart';
import 'package:falatu/app/presentation/chat/blocs/chats_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPrivateChatsBloc extends Bloc<ChatEvents, BaseState> {
  final GetPrivateChatsUseCase _useCase;

  GetPrivateChatsBloc(this._useCase) : super(EmptyState()) {
    on<LoadPrivateChats>((event, emit) {
      emit(LoadingState());
      final Stream<List<ChatEntity>> chatStream =
          _useCase.getPrivateChats(event.userId);
      return emit
          .forEach(chatStream, onData: (data) => SuccessState(data))
          .onError((error, stackTrace) =>
              ErrorState('Conversas não foram carregadas corretamente: ${error.toString()}'));
    });
  }
}
