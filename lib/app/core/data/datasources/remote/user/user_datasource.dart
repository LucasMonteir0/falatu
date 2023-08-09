import 'package:falatu/app/core/data/models/user_model.dart';

abstract class UserDatasource {
  Future<UserModel> getUser();

  Future<bool> verifyAuthUser();
}
