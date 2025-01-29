import "package:falatu_mobile/app/core/data/datasources/auth/auth_datasource.dart";
import "package:falatu_mobile/app/core/data/models/sign_in_model.dart";
import "package:falatu_mobile/app/core/data/models/sign_up_model.dart";
import "package:falatu_mobile/app/core/domain/entities/sign_in_entity.dart";
import "package:falatu_mobile/app/core/domain/entities/sign_in_response_entity.dart";
import "package:falatu_mobile/app/core/domain/entities/sign_up_entity.dart";
import "package:falatu_mobile/app/core/domain/repositories/auth/auth_repository.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/utils/get_it.dart";

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource = getIt.get<AuthDatasource>();

  AuthRepositoryImpl();

  @override
  Future<ApiResult<SignInResponseEntity>> signIn(SignInEntity params) {
    return _datasource.signIn(SignInModel.fromObject(params));
  }

  @override
  Future<ApiResult<UserEntity>> signUp(SignUpEntity params) {
    return _datasource.signUp(SignUpModel.fromObject(params));
  }
}
