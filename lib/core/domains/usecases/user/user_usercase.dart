import 'package:falatu/core/domains/entities/user_entity.dart';

abstract class UserUseCase {
  Future<UserEntity> getUser();

  Future<bool> verifyAuthUser();
}