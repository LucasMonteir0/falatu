import "package:falatu_mobile/commons/core/domain/usecases/sign_out/sign_out_use_case.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SignOutBloc extends Cubit<BaseState> {
  final SignOutUseCase _useCase;

  SignOutBloc(this._useCase) : super(const InitialState());

  Future<void> call() async {
    emit(LoadingState());
    final bool result = await _useCase.call();
    emit(SuccessState(result));
    return;
  }
}
