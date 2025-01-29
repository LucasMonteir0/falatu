import 'package:falatu_mobile/commons/core/domain/entities/api_result.dart';
import 'package:falatu_mobile/sign_in/core/data/models/sign_in_model.dart';
import 'package:falatu_mobile/sign_in/core/data/models/sign_in_response_model.dart';


abstract class AuthDatasource {
  Future<ApiResult<SignInResponseModel>> signIn(SignInModel params);
}