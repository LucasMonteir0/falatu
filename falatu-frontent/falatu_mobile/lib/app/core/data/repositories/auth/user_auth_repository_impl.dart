import 'package:falatu/app/core/data/datasources/remote/auth/auth_datasource.dart';
import 'package:falatu/app/core/domains/repositories/auth/user_auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<String?> registerUser(String email, String password, String firstName,
      String lastName, String pictureUrl) {
    return datasource.registerUser(
        email, password, firstName, lastName, pictureUrl);
  }

  @override
  Future<String> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<void> signOut() async {
    return await datasource.signOut();
  }
}
