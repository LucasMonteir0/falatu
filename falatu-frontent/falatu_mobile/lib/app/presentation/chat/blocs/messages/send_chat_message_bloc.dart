import 'dart:io';

import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/core/domains/usecases/chat/messages/send_chat_message_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendChatMessageBloc extends Cubit<BaseState> {
  final SendChatMessageUseCase _useCase;

  SendChatMessageBloc(this._useCase) : super(EmptyState());

  Future<void> call(
      {required ChatEntity chat,
      required MessageEntity message,
      File? file}) async {
    emit(LoadingState());
    try {
      await _useCase.sendChatMessage(chat, message, file);
      emit(SuccessState(null));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
