import "package:falatu_mobile/app/core/domain/entities/sign_in_entity.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_in/sign_in_use_case.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SignInBloc extends Cubit<BaseState> {
  final SignInUseCase _useCase;

  SignInBloc(this._useCase) : super(const InitialState());

  void call(String email, String password) async {
    emit(LoadingState());
    final result =
        await _useCase.call(SignInEntity(email: email, password: password));

    if (result.success) {
      emit(SuccessState(result.data));
      return;
    }
    emit(ErrorState(result.error));
  }
}
