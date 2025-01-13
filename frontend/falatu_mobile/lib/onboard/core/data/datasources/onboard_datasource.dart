import 'package:falatu_mobile/commons/core/domain/entities/api_result.dart';
import 'package:falatu_mobile/onboard/core/data/models/create_user_model.dart';

abstract class OnboardDatasource {
  Future<ApiResult> createUser(CreateUserModel params);
}