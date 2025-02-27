import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";

abstract class GetNonFriendsUseCase {
  Future<ResultWrapper<List<UserEntity>>> call();
}
