import "package:falatu_mobile/app/core/domain/entities/sign_up_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";

abstract class SignUpUseCase {
  Future<ResultWrapper<UserEntity>> call(SignUpEntity params);
}
