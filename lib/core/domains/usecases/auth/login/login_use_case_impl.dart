import 'package:falatu/core/domains/repositories/auth/user_auth_repository.dart';
import 'package:falatu/core/domains/usecases/auth/login/login_use_case.dart';

class LoginUseCaseImpl implements LoginUseCase{
  final AuthRepository _repository;

  LoginUseCaseImpl(this._repository);

  @override
  Future<bool> login(String email, String password) {
    return _repository.login(email, password);
  }
}