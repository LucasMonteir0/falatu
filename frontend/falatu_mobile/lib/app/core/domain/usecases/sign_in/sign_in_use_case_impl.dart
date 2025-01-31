import "package:falatu_mobile/app/core/domain/entities/sign_in_entity.dart";
import "package:falatu_mobile/app/core/domain/entities/sign_in_response_entity.dart";
import "package:falatu_mobile/app/core/domain/repositories/auth/auth_repository.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_in/sign_in_use_case.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";

class SignInUseCaseImpl implements SignInUseCase {
  final AuthRepository _repository;

  SignInUseCaseImpl(this._repository);

  @override
  Future<ApiResult<SignInResponseEntity>> call(SignInEntity params) {
    return _repository.signIn(params);
  }
}
