import 'package:falatu/app/core/data/datasources/remote/user/user_datasource.dart';
import 'package:falatu/app/core/data/models/user_model.dart';
import 'package:falatu/app/core/domains/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<UserModel> getUser() async {
    return await datasource.getUser();
  }

  @override
  Future<bool> verifyAuthUser() async {
    return await datasource.verifyAuthUser();
  }
}
