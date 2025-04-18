import "package:equatable/equatable.dart";

class AuthCredentialsEntity extends Equatable {
  final String userId;
  final String accessToken;
  final String refreshToken;

  const AuthCredentialsEntity(
      {required this.userId,
      required this.accessToken,
      required this.refreshToken});

  @override
  List<Object?> get props => [userId, accessToken, refreshToken];
}
