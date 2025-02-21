import "package:jwt_decoder/jwt_decoder.dart";

class JwtHelper {
  JwtHelper._();

  static DateTime getExpirationDate(String token) {
    final decoded = JwtDecoder.decode(token);
    return DateTime.fromMillisecondsSinceEpoch(decoded["exp"] * 1000);
  }
}
