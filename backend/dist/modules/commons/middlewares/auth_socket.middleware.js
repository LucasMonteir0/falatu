"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthSocketMiddleware = void 0;
const query_helper_1 = require("../../../utils/helpers/query.helper");
const AppError_1 = require("../../../utils/result/AppError");
const AuthSocketMiddleware = (jwtService, primsaService) => {
    return async (socket, next) => {
        try {
            const token = socket.handshake?.headers?.authorization;
            if (!token) {
                throw new Error("Authorization token is missing");
            }
            let payload = null;
            try {
                payload = await jwtService.verifyAsync(token);
            }
            catch (error) {
                next(new AppError_1.ConflictError("Token is invalid."));
            }
            const user = await primsaService.user.findUnique({
                where: { id: payload.userId },
                select: query_helper_1.QueryHelper.selectUser().select,
            });
            if (!user) {
                next(new AppError_1.NotFoundError("User does not exist"));
            }
            socket = Object.assign(socket, {
                user: user,
            });
            next();
            return socket;
        }
        catch (error) {
            next(new AppError_1.UnauthorizedError("Token must be provided"));
        }
    };
};
exports.AuthSocketMiddleware = AuthSocketMiddleware;
//# sourceMappingURL=auth_socket.middleware.js.map