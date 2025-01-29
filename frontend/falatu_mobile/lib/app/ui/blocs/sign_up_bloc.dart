import "dart:io";

import "package:falatu_mobile/app/core/domain/entities/sign_up_entity.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_up/sign_up_use_case.dart";
import "package:falatu_mobile/commons/utils/get_it.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SignInBloc extends Cubit<BaseState> {
  final SignUpUseCase _useCase = getIt.get<SignUpUseCase>();

  SignInBloc() : super(const InitialState());

  void call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    File? picture,
  }) async {
    emit(LoadingState());
    final result = await _useCase.call(SignUpEntity(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        picture: picture));

    if (result.success) {
      emit(SuccessState(result.data));
      return;
    }
    emit(ErrorState(result.error));
  }
}
