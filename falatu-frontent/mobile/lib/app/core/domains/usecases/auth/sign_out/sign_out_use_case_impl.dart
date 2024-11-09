import 'package:falatu/app/core/domains/repositories/auth/user_auth_repository.dart';
import 'package:falatu/app/core/domains/usecases/auth/sign_out/sign_out_use_case.dart';

class SignOutUseCaseImpl implements SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCaseImpl(this._repository);

  @override
  Future<void> signOut() async {
    return await _repository.signOut();
  }
}
