interface JwtTokenService {
    generateAccessToken(userId: string): any;
    generateRefreshToken(userId: string): any;
    verifyAccessToken(token: string): string;
    refreshAccessToken(token: string): string;
}
