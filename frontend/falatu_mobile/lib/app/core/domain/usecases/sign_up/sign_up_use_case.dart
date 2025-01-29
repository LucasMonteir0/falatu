import "package:falatu_mobile/app/core/domain/entities/sign_up_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";

abstract class SignUpUseCase {
  Future<ApiResult<UserEntity>> call(SignUpEntity params);
}
