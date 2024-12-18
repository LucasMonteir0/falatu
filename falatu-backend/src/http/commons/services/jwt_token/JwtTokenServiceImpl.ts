// import { JwtPayload, sign, verify } from 'jsonwebtoken';
// import { injectable } from 'tsyringe';
// import { UnauthorizedError } from '../../../../utils/result/AppError';

// interface CustomJwtPayload extends JwtPayload {
//   userId: string;
// }

// @injectable()
// export class JwtTokenServiceImpl implements JwtTokenService {
//   private accessSecret = process.env.JWT_ACCESS_SECRET;
//   private refreshSecret = process.env.JWT_REFRESH_SECRET;

//   public generateAccessToken(userId: string): string {
//     return sign({ userId }, this.accessSecret, { expiresIn: '1d' });
//   }

//   public generateRefreshToken(userId: string): string {
//     return sign({ userId }, this.refreshSecret, { expiresIn: '7d' });
//   }

//   public verifyAccessToken(token: string): string {
//     try {
//       const decoded: JwtPayload | string = verify(
//         token,
//         this.accessSecret,
//       ) as CustomJwtPayload;
//       return decoded.userId;
//     } catch (error) {
//       throw new UnauthorizedError('Invalid or expired access token');
//     }
//   }

//   public refreshAccessToken(refreshToken: string): string {
//     try {
//       const decoded = verify(
//         refreshToken,
//         this.refreshSecret,
//       ) as CustomJwtPayload;
//       return this.generateAccessToken(decoded.userId);
//     } catch (error) {
//       throw new UnauthorizedError('Invalid or expired refresh token');
//     }
//   }
// }
