import 'package:falatu_mobile/commons/utils/get_it.dart';
import 'package:falatu_mobile/commons/utils/states/base_state.dart';
import 'package:falatu_mobile/sign_in/core/domain/entities/sign_in_entity.dart';
import 'package:falatu_mobile/sign_in/core/domain/usecases/sign_in_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Cubit<BaseState> {
  final SignInUseCase useCase = getIt.get<SignInUseCase>();

  SignInBloc() : super(InitialState());

  void call(String email, String password) async {
    emit(LoadingState());
    final result =
        await useCase.call(SignInEntity(email: email, password: password));

    if (result.success) {
      emit(SuccessState(result.data));
      return;
    }
    emit(ErrorState(result.error));
  }
}
