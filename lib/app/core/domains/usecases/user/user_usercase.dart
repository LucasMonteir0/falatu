import 'package:falatu/app/core/domains/entities/user/user_entity.dart';

abstract class UserUseCase {
  Future<UserEntity> getUser();

  Future<bool> verifyAuthUser();
}
