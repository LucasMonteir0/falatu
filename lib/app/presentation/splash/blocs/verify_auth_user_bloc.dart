import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/core/domains/usecases/user/user_usercase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyAuthUserBloc extends Cubit<BaseState> {
  VerifyAuthUserBloc(this.useCase) : super(EmptyState());

  final UserUseCase useCase;

  void call() async {
    emit(LoadingState());
    try {
      final result = await useCase.verifyAuthUser();
      emit(SuccessState<bool>(result));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}