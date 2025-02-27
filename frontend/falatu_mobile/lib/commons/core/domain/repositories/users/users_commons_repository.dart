import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";

abstract class UsersCommonsRepository {
  Future<ResultWrapper<List<UserEntity>>> getNonFriends();
  Future<ResultWrapper<UserEntity>> getUser();
}