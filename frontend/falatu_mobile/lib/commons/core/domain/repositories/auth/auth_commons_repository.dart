import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";

abstract class AuthCommonsRepository {
  Future<ApiResult<AuthCredentialsEntity>> updateAccessToken();
}
