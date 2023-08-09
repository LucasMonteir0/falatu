import 'package:falatu/app/core/domains/repositories/auth/user_auth_repository.dart';
import 'package:falatu/app/core/domains/usecases/auth/register/register_user_use_case.dart';

class RegisterUserUseCaseImpl implements RegisterUserUseCase{
  final AuthRepository _repository;

  RegisterUserUseCaseImpl(this._repository);

  @override
  Future<String?> registerUser(String email, String password, String firstName,
      String lastName, String pictureUrl) {
    return _repository.registerUser(
        email, password, firstName, lastName, pictureUrl);
  }
}