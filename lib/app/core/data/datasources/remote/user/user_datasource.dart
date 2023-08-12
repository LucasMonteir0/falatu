import 'package:falatu/app/core/data/models/user_model.dart';

abstract class UserDatasource {
  Future<UserModel> getUser();

  Future<List<UserModel>> getAllUsers();

  Future<bool> verifyAuthUser();
}
