import 'package:falatu/core/domains/entities/user_entity.dart';

abstract class UserDatasource {
  Future<UserEntity> getUser();

  Future<bool> verifyAuthUser();
}
