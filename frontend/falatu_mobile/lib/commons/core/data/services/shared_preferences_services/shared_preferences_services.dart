abstract class SharedPreferencesService {
  Future<void> init();
  String? getUserAccessToken();

  String? getUserRefreshToken();

  Future<bool> setUserAccessToken(String token);

  Future<bool> setUserRefreshToken(String token);
}
