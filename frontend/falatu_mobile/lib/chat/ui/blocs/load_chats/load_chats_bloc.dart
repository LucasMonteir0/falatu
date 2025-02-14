import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/usecases/load_chats/load_chats_use_case.dart";
import "package:falatu_mobile/chat/ui/blocs/load_chats/load_chats_events.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class LoadChatsBloc extends Bloc<LoadChatsEvents, BaseState> {
  final LoadChatsUseCase _useCase;

  LoadChatsBloc(this._useCase) : super(LoadingState()) {
    on<Load>(_onLoad);
  }

  void _onLoad(Load event, Emitter<BaseState> emit) async {
    final result = _useCase.call();
    if (result.success) {
      await emit.forEach(
        result.data!,
        onData: SuccessState<List<ChatEntity>>.new,
      );
    } else {
      emit(ErrorState(result.error));
    }
  }
}
