import 'package:falatu/core/domains/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser();

  Future<bool> verifyAuthUser();
}
