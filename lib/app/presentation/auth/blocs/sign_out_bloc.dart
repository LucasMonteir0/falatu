import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/core/domains/usecases/auth/sign_out/sign_out_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignOutBloc extends Cubit<BaseState> {
  SignOutBloc(this._useCase) : super(EmptyState());

  final SignOutUseCase _useCase;
  Future<void> call() async {
    emit(LoadingState());
    try {
      await _useCase.signOut();
      emit(SuccessState(''));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
