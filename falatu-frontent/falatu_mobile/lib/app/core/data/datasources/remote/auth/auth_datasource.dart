abstract class AuthDatasource {

  Future<String?> registerUser(String email, String password, String firstName, String lastName, String pictureUrl);
  Future<String> login(String email, String password);
  Future<void> signOut();
}