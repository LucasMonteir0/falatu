import "package:falatu_mobile/app/core/domain/entities/sign_up_entity.dart";
import "package:falatu_mobile/app/core/domain/repositories/auth/auth_repository.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_up/sign_up_use_case.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";

class SignUpUseCaseImpl implements SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCaseImpl(this._repository);

  @override
  Future<ApiResult<UserEntity>> call(SignUpEntity params) {
    return _repository.signUp(params);
  }
}
