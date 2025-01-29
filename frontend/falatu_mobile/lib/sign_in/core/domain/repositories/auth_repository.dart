import 'package:falatu_mobile/commons/core/domain/entities/api_result.dart';
import 'package:falatu_mobile/sign_in/core/domain/entities/sign_in_entity.dart';
import 'package:falatu_mobile/sign_in/core/domain/entities/sign_in_response_entity.dart';

abstract class AuthRepository {
  Future<ApiResult<SignInResponseEntity>> signIn(SignInEntity params);
}