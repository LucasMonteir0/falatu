import 'package:falatu_mobile/commons/core/domain/entities/api_result.dart';
import 'package:falatu_mobile/commons/utils/get_it.dart';
import 'package:falatu_mobile/sign_in/core/data/datasources/auth_datasource.dart';
import 'package:falatu_mobile/sign_in/core/data/models/sign_in_model.dart';
import 'package:falatu_mobile/sign_in/core/domain/entities/sign_in_entity.dart';
import 'package:falatu_mobile/sign_in/core/domain/entities/sign_in_response_entity.dart';
import 'package:falatu_mobile/sign_in/core/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource = getIt.get<AuthDatasource>();

  AuthRepositoryImpl();

  @override
  Future<ApiResult<SignInResponseEntity>> signIn(SignInEntity params) {
    return _datasource.signIn(SignInModel.fromObject(params));
  }
}
