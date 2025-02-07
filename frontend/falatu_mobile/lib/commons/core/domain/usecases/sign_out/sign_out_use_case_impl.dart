import "package:falatu_mobile/commons/core/domain/repositories/auth/auth_commons_repository.dart";
import "package:falatu_mobile/commons/core/domain/usecases/sign_out/sign_out_use_case.dart";

class SignOutUseCaseImpl implements SignOutUseCase {
  final AuthCommonsRepository _repository;

  SignOutUseCaseImpl(this._repository);

  @override
  Future<bool> call() {
    return _repository.signOut();
  }
}
