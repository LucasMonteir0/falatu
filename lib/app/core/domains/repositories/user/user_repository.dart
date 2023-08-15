import 'package:falatu/app/core/domains/entities/user/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser();

  Future<List<UserEntity>> getAllUsers();

  Future<bool> verifyAuthUser();
}
