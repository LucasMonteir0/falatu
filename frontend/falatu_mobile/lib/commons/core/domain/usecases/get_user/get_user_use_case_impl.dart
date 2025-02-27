import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/core/domain/repositories/users/users_commons_repository.dart";
import "package:falatu_mobile/commons/core/domain/usecases/get_user/get_user_use_case.dart";

class GetUserUseCaseImpl implements GetUserUseCase {
  final UsersCommonsRepository _repository;

  GetUserUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<UserEntity>> call() {
    return _repository.getUser();
  }
}