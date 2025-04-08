import { JwtService } from "@nestjs/jwt";
import { Socket } from "socket.io";
import { PrismaService } from "src/modules/commons/utils/config/database/prisma.service";
import { QueryHelper } from "src/modules/commons/utils/helpers/query.helper";
import {
  ConflictError,
  NotFoundError,
  UnauthorizedError,
} from "src/modules/commons/utils/result/AppError";

type SocketMiddleware = (socket: Socket, next: (err?: Error) => void) => void;

export const AuthSocketMiddleware = (
  jwtService: JwtService,
  primsaService: PrismaService
): SocketMiddleware => {
  return async (socket: Socket, next) => {
    try {
      const token = socket.handshake?.headers?.authorization;

      if (!token) {
        throw new Error("Authorization token is missing");
      }

      let payload: JwtPayload | null = null;

      try {
        payload = await jwtService.verifyAsync<JwtPayload>(token);
      } catch (error) {
        next(new ConflictError("Token is invalid."));
      }
      const user = await primsaService.user.findUnique({
        where: { id: payload.userId },
        select: QueryHelper.selectUser().select,
      });
      if (!user) {
        next(new NotFoundError("User does not exist"));
      }

      socket = Object.assign(socket, {
        user: user,
      });
      next();
      return socket;
    } catch (error) {
      next(new UnauthorizedError("Token must be provided"));
    }
  };
};
