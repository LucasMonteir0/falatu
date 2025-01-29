import "package:falatu_mobile/app/core/domain/entities/sign_in_entity.dart";
import "package:falatu_mobile/app/core/domain/entities/sign_in_response_entity.dart";
import "package:falatu_mobile/app/core/domain/entities/sign_up_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";

abstract class AuthRepository {
  Future<ApiResult<SignInResponseEntity>> signIn(SignInEntity params);
  Future<ApiResult<UserEntity>> signUp(SignUpEntity params);

}