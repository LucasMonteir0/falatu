import 'package:falatu/modules/auth/core/data/datasources/remote/user_auth/user_auth_datasource.dart';
import 'package:falatu/modules/auth/core/domains/repositories/user_auth/user_auth_repository.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {

  final UserAuthDatasource datasource;

  UserAuthRepositoryImpl(this.datasource);

  @override
  Future<String?> registerUser(String email, String password, String firstName, String lastName, String pictureUrl) {
    return datasource.registerUser(email, password, firstName, lastName, pictureUrl);
  }

}