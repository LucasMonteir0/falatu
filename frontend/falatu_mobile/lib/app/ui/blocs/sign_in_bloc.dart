import "package:falatu_mobile/app/core/domain/entities/sign_in_entity.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_in/sign_in_use_case.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SignInBloc extends Cubit<BaseState> {
  final SignInUseCase _useCase;
  final SharedPreferencesService _preferences;

  SignInBloc(this._useCase, this._preferences) : super(const InitialState());

  void call(String email, String password) async {
    emit(LoadingState());
    final result =
        await _useCase.call(SignInEntity(email: email, password: password));

    if (result.success) {
      final data = result.data as AuthCredentialsEntity;
      await _preferences.setUserAccessToken(data.accessToken);
      await _preferences.setUserRefreshToken(data.refreshToken);
      emit(SuccessState(result.data));
      return;
    }
    emit(ErrorState(result.error));
  }
}
