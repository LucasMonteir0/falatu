import { compare } from "bcryptjs";
import { ResultWrapper } from "../../../utils/result/ResultWrapper";

import {
  NotFoundError,
  UnauthorizedError,
  UnknownError,
} from "../../../utils/result/AppError";
import { Injectable } from "@nestjs/common";
import { AuthDatasource } from "./auth.datasource";
import { SignInDTO } from "../dtos/sign_in.dto";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { JwtService } from "@nestjs/jwt";
import { jwtSecret } from "../../../utils/constants";

@Injectable()
export class PrismaAuthDatasourceImpl implements AuthDatasource {
  constructor(
    private readonly jwtService: JwtService,
    private readonly database: PrismaService
  ) {}

  async signIn(
    credentials: SignInDTO
  ): Promise<ResultWrapper<AuthResponseDTO>> {
    const user = await this.database.user.findUnique({
      where: { email: credentials.email },
    });


    const { password, id } = user;
    const isPasswordValid = await compare(credentials.password, password);

    if (!user || !isPasswordValid) {
      const e = new NotFoundError("invalid e-mail or password");
      return ResultWrapper.error(e);
    }

    const payload: JwtPayload = { userId: user.id };

    const access = await this.jwtService.signAsync(payload);
    const refresh = await this.jwtService.signAsync(payload, {
      expiresIn: "7d",
    });

    return ResultWrapper.success<AuthResponseDTO>({
      uid: id,
      access,
      refresh,
    });
  }

  async refreshToken(token: string): Promise<ResultWrapper<AuthResponseDTO>> {
    try {
      const payload: JwtPayload = this.jwtService.verify(token, {
        secret: jwtSecret,
      });

      const { userId } = payload;

      const access = await this.jwtService.signAsync({ userId });
      const refresh = await this.jwtService.signAsync({ userId }, {
        expiresIn: "7d",
      });

      return ResultWrapper.success<AuthResponseDTO>({
        uid: payload.userId,
        access,
        refresh,
      });
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }
}
