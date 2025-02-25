import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/usecases/send_message/send_message_use_case.dart";
import "package:falatu_mobile/chat/core/domain/usecases/update_last_message/update_last_message_use_case.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SendMessageBloc extends Cubit<BaseState> {
  final SendMessageUseCase _sendMessage;
  final UpdateLastMessageUseCase _updateLastMessage;

  SendMessageBloc(this._sendMessage, this._updateLastMessage)
      : super(const InitialState());

  void call(String chatId, SendMessageEntity message) {
    emit(LoadingState());
    _sendMessage.call(chatId, message);
    emit(const SuccessState(null));
  }
}
