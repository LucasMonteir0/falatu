abstract class UserAuthRepository {

  Future<String?> registerUser(String email, String password, String firstName, String lastName, String pictureUrl);
}