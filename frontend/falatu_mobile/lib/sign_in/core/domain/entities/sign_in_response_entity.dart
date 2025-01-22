class SignInResponseEntity {
  final String userId;
  final String accessToken;
  final String refreshToken;

  SignInResponseEntity(
      {required this.userId,
      required this.accessToken,
      required this.refreshToken});
}
