import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/create_chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/usecases/create_chat/create_chat_use_case.dart";
import "package:falatu_mobile/chat/ui/blocs/create_chat/create_chat_events.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class CreateChatBloc extends Bloc<CreateChatEvents, BaseState> {
  final CreateChatUseCase _useCase;

  CreateChatBloc(this._useCase) : super(const InitialState()) {
    on<Create>(_onLoad);
  }

  void _onLoad(Create event, Emitter<BaseState> emit) async {
    emit(LoadingState());
    final result = _useCase
        .call(CreateChatEntity(type: event.type, usersIds: event.usersIds));
    if (result.success) {
      await emit.forEach(result.data!, onData: SuccessState<ChatEntity>.new);
    } else {
      emit(ErrorState(result.error));
    }
  }
}
