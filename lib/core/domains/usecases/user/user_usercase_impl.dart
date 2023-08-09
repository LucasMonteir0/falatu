import 'package:falatu/core/domains/entities/user_entity.dart';
import 'package:falatu/core/domains/repositories/user/user_repository.dart';
import 'package:falatu/core/domains/usecases/user/user_usercase.dart';

class UserUseCaseImpl implements UserUseCase {
  final UserRepository repository;

  UserUseCaseImpl(this.repository);

  @override
  Future<UserEntity> getUser() async {
    return await repository.getUser();
  }

  @override
  Future<bool> verifyAuthUser() async {
    return await repository.verifyAuthUser();
  }
}
