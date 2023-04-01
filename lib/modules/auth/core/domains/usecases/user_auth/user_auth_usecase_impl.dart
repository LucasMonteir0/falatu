import 'package:falatu/modules/auth/core/domains/repositories/user_auth/user_auth_repository.dart';
import 'package:falatu/modules/auth/core/domains/usecases/user_auth/user_auth_usecase.dart';

class UserAuthUseCaseImpl implements UserAuthUseCase{

 final UserAuthRepository repository;

  UserAuthUseCaseImpl(this.repository);

  @override
  Future<String?> registerUser(String email, String password, String firstName, String lastName, String pictureUrl) {
    return repository.registerUser(email, password, firstName, lastName, pictureUrl);
  }
}