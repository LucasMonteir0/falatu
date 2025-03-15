import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/app/core/domain/entities/sign_up_entity.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_up/sign_up_use_case.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SignUpBloc extends Cubit<BaseState> {
  final SignUpUseCase _useCase;

  SignUpBloc(this._useCase) : super(const InitialState());

  void call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    XFile? picture,
  }) async {
    emit(LoadingState());
    final result = await _useCase.call(SignUpEntity(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        picture: picture));

    if (result.success) {
      emit(SuccessState<UserEntity>(result.data!));
      return;
    } else if (result.error is ConflictError) {
      emit(ErrorState<ConflictError>(result.error));
      return;
    }
    emit(ErrorState(result.error));
  }
}
