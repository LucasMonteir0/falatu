import 'package:falatu/core/data/datasources/remote/user/user_datasource.dart';
import 'package:falatu/core/domains/entities/user_entity.dart';
import 'package:falatu/core/domains/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<UserEntity> getUser() async {
    return await datasource.getUser();
  }

  @override
  Future<bool> verifyAuthUser() async {
    return await datasource.verifyAuthUser();
  }
}
