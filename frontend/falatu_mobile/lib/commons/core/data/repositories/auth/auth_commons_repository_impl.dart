import "package:falatu_mobile/commons/core/data/datasources/auth/auth_commons_datasource.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/repositories/auth/auth_commons_repository.dart";

class AuthCommonsRepositoryImpl implements AuthCommonsRepository {
  final AuthCommonsDatasource _datasource;

  AuthCommonsRepositoryImpl(this._datasource);

  @override
  Future<ResultWrapper<AuthCredentialsEntity>> updateAccessToken([bool forceRefresh = false]) {
    return _datasource.updateAccessToken(forceRefresh);
  }

  @override
  Future<bool> signOut() {
    return _datasource.signOut();
  }
}
