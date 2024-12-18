import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/core/domains/usecases/auth/login/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Cubit<BaseState> {
  LoginBloc(this._useCase) : super(EmptyState());

  final LoginUseCase _useCase;

  Future<void> call(String email, String password) async {
    emit(LoadingState());
    try {
      await _useCase.login(email, password);
      emit(SuccessState(null));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
