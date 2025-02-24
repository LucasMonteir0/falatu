import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/usecases/update_access_token/update_access_token_use_case.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class UpdateAccessTokenBloc extends Cubit<BaseState> {
  final UpdateAccessTokenUseCase _useCase;
  final SharedPreferencesService _preferences;

  UpdateAccessTokenBloc(this._useCase, this._preferences)
      : super(const InitialState());

  Future<void> call([bool forceRefresh = false]) async {
    emit(LoadingState());
    final ResultWrapper<AuthCredentialsEntity> result = await _useCase.call(forceRefresh);
    if (result.success) {
      final auth = result.data as AuthCredentialsEntity;
      await _preferences.setUserAccessToken(auth.accessToken);
      await _preferences.setUserRefreshToken(auth.refreshToken);
      emit(SuccessState<AuthCredentialsEntity>(auth));
      return;
    }
    emit(ErrorState(result.error));
  }
}
