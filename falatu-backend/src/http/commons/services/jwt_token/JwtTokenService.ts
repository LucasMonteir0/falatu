interface JwtTokenService {
  generateAccessToken(userId: string);
  generateRefreshToken(userId: string);
  verifyAccessToken(token: string): string;
  refreshAccessToken(token: string): string;
}
