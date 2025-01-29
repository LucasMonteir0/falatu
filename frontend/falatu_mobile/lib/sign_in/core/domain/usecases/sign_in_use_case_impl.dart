import 'package:falatu_mobile/commons/core/domain/entities/api_result.dart';
import 'package:falatu_mobile/commons/utils/get_it.dart';
import 'package:falatu_mobile/sign_in/core/domain/entities/sign_in_entity.dart';
import 'package:falatu_mobile/sign_in/core/domain/entities/sign_in_response_entity.dart';
import 'package:falatu_mobile/sign_in/core/domain/repositories/auth_repository.dart';
import 'package:falatu_mobile/sign_in/core/domain/usecases/sign_in_use_case.dart';

class SignInUseCaseImpl implements SignInUseCase {
  final AuthRepository _repository = getIt.get<AuthRepository>();

  @override
  Future<ApiResult<SignInResponseEntity>> call(SignInEntity params) {
    return _repository.signIn(params);
  }
}
