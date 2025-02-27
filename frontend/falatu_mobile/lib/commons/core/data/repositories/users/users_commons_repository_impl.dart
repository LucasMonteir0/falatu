import "package:falatu_mobile/commons/core/data/datasources/users/users_commons_datasource.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/core/domain/repositories/users/users_commons_repository.dart";

class UsersCommonsRepositoryImpl implements UsersCommonsRepository {
  final UsersCommonsDatasource _datasource;

  UsersCommonsRepositoryImpl(this._datasource);

  @override
  Future<ResultWrapper<List<UserEntity>>> getNonFriends() {
    return _datasource.getNonFriends();
  }

  @override
  Future<ResultWrapper<UserEntity>> getUser() {
    return _datasource.getUser();
  }
}
