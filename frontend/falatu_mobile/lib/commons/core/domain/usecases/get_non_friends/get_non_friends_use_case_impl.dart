import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/core/domain/repositories/users/users_commons_repository.dart";
import "package:falatu_mobile/commons/core/domain/usecases/get_non_friends/get_non_friends_use_case.dart";

class GetNonFriendsUseCaseImpl implements GetNonFriendsUseCase {
  final UsersCommonsRepository _repository;

  GetNonFriendsUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<List<UserEntity>>> call() {
    return _repository.getNonFriends();
  }
}
