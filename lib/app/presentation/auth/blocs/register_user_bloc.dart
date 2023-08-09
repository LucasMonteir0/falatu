import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/core/domains/usecases/auth/register/register_user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterUserBloc extends Cubit<BaseState> {
  RegisterUserBloc(this._useCase) : super(EmptyState());

  final RegisterUserUseCase _useCase;

  void call(String email, String password, String firstName, String lastName,
      String picture) {
    emit(LoadingState());
    try {
      final result =
          _useCase.registerUser(email, password, firstName, lastName, picture);
      emit(SuccessState(result));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
