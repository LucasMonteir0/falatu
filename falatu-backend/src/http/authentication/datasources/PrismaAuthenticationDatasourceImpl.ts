// import { AuthenticationDatasource } from './AuthenticationDatasource';
// import { inject, injectable } from 'tsyringe';
// import { compare } from 'bcryptjs';
// import { SignInCredentialsEntity } from '../entities/SignInCredentialsEntity';
// import { ResultWrapper } from '../../../utils/result/ResultWrapper';
// import { database } from '../../../config/database';
// import {
//   NotFoundError,
//   UnauthorizedError,
// } from '../../../utils/result/AppError';

// @injectable()
// export class PrismaAuthenticationDatasourceImpl
//   implements AuthenticationDatasource
// {
//   public constructor(
//     @inject('JwtTokenService')
//     private jwtTokenService: JwtTokenService,
//   ) {}

//   async signIn(
//     credentials: SignInCredentialsEntity,
//   ): Promise<ResultWrapper<UserAuthenticationTokensEntity>> {
//     let whereProps;
//     if (credentials.login.includes('@')) {
//       whereProps = { email: credentials.login };
//     } else {
//       whereProps = { username: credentials.login };
//     }

//     const user = await database.user.findUnique({
//       where: whereProps,
//     });

//     if (!user) {
//       const e = new NotFoundError('invalid e-mail or password');
//       return ResultWrapper.error(e);
//     }

//     const { password, id } = user;
//     const isPasswordValid = await compare(credentials.password, password);

//     if (!isPasswordValid) {
//       const e = new UnauthorizedError('invalid e-mail or password');
//       return ResultWrapper.error(e);
//     }

//     const access = this.jwtTokenService.generateAccessToken(id);
//     const refresh = this.jwtTokenService.generateRefreshToken(id);

//     return ResultWrapper.success<UserAuthenticationTokensEntity>({
//       uid: id,
//       access,
//       refresh,
//     });
//   }
// }
