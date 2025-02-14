import "package:falatu_mobile/app/core/data/datasources/auth/auth_datasource.dart";
import "package:falatu_mobile/app/core/data/models/sign_in_model.dart";
import "package:falatu_mobile/app/core/data/models/sign_up_model.dart";
import "package:falatu_mobile/app/core/domain/entities/sign_in_entity.dart";
import "package:falatu_mobile/app/core/domain/entities/sign_up_entity.dart";
import "package:falatu_mobile/app/core/domain/repositories/auth/auth_repository.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource ;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<ResultWrapper<AuthCredentialsEntity>> signIn(SignInEntity params) {
    return _datasource.signIn(SignInModel.fromObject(params));
  }

  @override
  Future<ResultWrapper<UserEntity>> signUp(SignUpEntity params) {
    return _datasource.signUp(SignUpModel.fromObject(params));
  }
}
