import "package:falatu_mobile/app/core/domain/entities/sign_in_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";

abstract class SignInUseCase {
  Future<ApiResult<AuthCredentialsEntity>> call(SignInEntity params);

}