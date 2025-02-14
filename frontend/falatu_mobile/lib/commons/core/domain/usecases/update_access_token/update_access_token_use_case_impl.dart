import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/repositories/auth/auth_commons_repository.dart";
import "package:falatu_mobile/commons/core/domain/usecases/update_access_token/update_access_token_use_case.dart";

class UpdateAccessTokenUseCaseImpl  implements UpdateAccessTokenUseCase{
  final AuthCommonsRepository _repository;

  UpdateAccessTokenUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<AuthCredentialsEntity>> call() {
    return _repository.updateAccessToken();
  }
}