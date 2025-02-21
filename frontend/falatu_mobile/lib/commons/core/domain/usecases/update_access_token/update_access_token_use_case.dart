import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

abstract class UpdateAccessTokenUseCase {
  Future<ResultWrapper<AuthCredentialsEntity>> call(bool forceRefresh);
}