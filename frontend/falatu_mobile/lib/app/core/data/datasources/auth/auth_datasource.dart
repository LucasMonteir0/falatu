import "package:falatu_mobile/app/core/data/models/sign_in_model.dart";
import "package:falatu_mobile/app/core/data/models/sign_in_response_model.dart";
import "package:falatu_mobile/app/core/data/models/sign_up_model.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";


abstract class AuthDatasource {
  Future<ApiResult<SignInResponseModel>> signIn(SignInModel params);
  Future<ApiResult<UserModel>> signUp(SignUpModel params);

}