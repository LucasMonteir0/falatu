import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/usecases/load_messages/load_messages_use_case.dart";
import "package:falatu_mobile/chat/ui/blocs/load_messages/message_events.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class LoadMessagesBloc extends Bloc<MessageEvents, BaseState> {
  final LoadMessagesUseCase _useCase;

  LoadMessagesBloc(this._useCase) : super(LoadingState()) {
    on<LoadMessages>(_onLoad);
  }

  void _onLoad(LoadMessages event, Emitter<BaseState> emit) async {
    final result = _useCase.call(event.chatId);
    if (result.success) {
      await emit.forEach(
        result.data!,
        onData: SuccessState<List<MessageEntity>>.new,
      );
    } else {
      emit(ErrorState(result.error));
    }
  }
}
