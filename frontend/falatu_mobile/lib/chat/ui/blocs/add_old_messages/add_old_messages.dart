import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/usecases/get_old_messages/add_old_messages_use_case.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AddOldMessagesBloc extends Cubit<BaseState> {
  final AddOldMessagesUseCase _useCase;

  AddOldMessagesBloc(this._useCase) : super(const InitialState());

  void call(String chatId, int page) async {
    emit(LoadingState());
    _useCase.call(chatId, page);
    emit(const SuccessState(null));
  }
}
