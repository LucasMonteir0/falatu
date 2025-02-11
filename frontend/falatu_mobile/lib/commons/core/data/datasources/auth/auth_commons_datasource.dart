import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";

abstract class AuthCommonsDatasource {
  Future<ResultWrapper<AuthCredentialsEntity>> updateAccessToken();
  Future<bool> signOut();
}