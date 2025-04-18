import "package:falatu_mobile/app/core/domain/entities/sign_in_entity.dart";
import "package:falatu_mobile/app/core/domain/repositories/auth/auth_repository.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_in/sign_in_use_case.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

class SignInUseCaseImpl implements SignInUseCase {
  final AuthRepository _repository;

  SignInUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<AuthCredentialsEntity>> call(SignInEntity params) {
    return _repository.signIn(params);
  }
}
