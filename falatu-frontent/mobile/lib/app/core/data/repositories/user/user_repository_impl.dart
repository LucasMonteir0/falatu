import 'package:falatu/app/core/data/datasources/remote/user/user_datasource.dart';
import 'package:falatu/app/core/data/models/user/user_model.dart';
import 'package:falatu/app/core/domains/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource _datasource;

  UserRepositoryImpl(this._datasource);

  @override
  Future<UserModel> getUser() async {
    return await _datasource.getUser();
  }

  @override
  Future<bool> verifyAuthUser() async {
    return await _datasource.verifyAuthUser();
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    return await _datasource.getAllUsers();
  }
}
