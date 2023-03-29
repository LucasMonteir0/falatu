abstract class ISignUpController {
  Future<String?> registerUser(String email, String password, String firstName);
}
