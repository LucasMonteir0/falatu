import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/usecases/update_access_token/update_access_token_use_case.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class UpdateAccessTokenBloc extends Cubit<BaseState> {
  final UpdateAccessTokenUseCase _useCase;

  UpdateAccessTokenBloc(this._useCase)
      : super(const InitialState());

  Future<void> call([bool forceRefresh = false]) async {
    emit(LoadingState());
    final ResultWrapper<AuthCredentialsEntity> result = await _useCase.call(forceRefresh);
    if (result.success) {
      final auth = result.data as AuthCredentialsEntity;
      emit(SuccessState<AuthCredentialsEntity>(auth));
      return;
    }
    emit(ErrorState(result.error));
  }
}
