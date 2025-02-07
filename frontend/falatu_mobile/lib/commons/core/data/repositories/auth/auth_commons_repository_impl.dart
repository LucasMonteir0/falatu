import "package:falatu_mobile/commons/core/data/datasources/auth/auth_commons_datasource.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/repositories/auth/auth_commons_repository.dart";

class AuthCommonsRepositoryImpl implements AuthCommonsRepository {
  final AuthCommonsDatasource _datasource;

  AuthCommonsRepositoryImpl(this._datasource);

  @override
  Future<ApiResult<AuthCredentialsEntity>> updateAccessToken() {
    return _datasource.updateAccessToken();
  }

  @override
  Future<bool> signOut() {
    return _datasource.signOut();
  }
}
