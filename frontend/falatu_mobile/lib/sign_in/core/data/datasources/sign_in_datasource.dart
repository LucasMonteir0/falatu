import 'package:falatu_mobile/commons/core/data/models/user_model.dart';
import 'package:falatu_mobile/commons/core/domain/entities/api_result.dart';
import 'package:falatu_mobile/sign_in/core/data/models/sign_in_model.dart';


abstract class SignInDatasource {
  Future<ApiResult<UserModel>> signIn(SignInModel params);
}