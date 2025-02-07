abstract class SharedPreferencesService {
  Future<void> init();

  String? getUserId();

  String? getUserAccessToken();

  String? getUserRefreshToken();

  Future<bool> setUserId(String id);

  Future<bool> setUserAccessToken(String token);

  Future<bool> setUserRefreshToken(String token);
  Future<bool> removeAuthCaches();
}
