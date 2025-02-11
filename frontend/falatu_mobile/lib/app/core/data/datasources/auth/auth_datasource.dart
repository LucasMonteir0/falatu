import "package:falatu_mobile/app/core/data/models/sign_in_model.dart";
import "package:falatu_mobile/app/core/data/models/sign_up_model.dart";
import "package:falatu_mobile/commons/core/data/models/auth_credentials_model.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";


abstract class AuthDatasource {
  Future<ResultWrapper<AuthCredentialsModel>> signIn(SignInModel params);
  Future<ResultWrapper<UserModel>> signUp(SignUpModel params);

}