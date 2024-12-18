// import { NextFunction, Request, Response } from "express";
// import { container } from "tsyringe";
// import { UnauthorizedError } from "../../../utils/result/AppError";

// export function authMiddleware(
//   req: Request,
//   res: Response,
//   next: NextFunction
// ) {
//   const { authorization } = req.headers;

//   if (!authorization) {
//     const e = new UnauthorizedError("Token not provided");
//     return res.status(e.status).json({ message: e.message });
//   }

//   const [, token] = authorization.split(" ");

//   try {
//     const jwtService = container.resolve<JwtTokenService>("JwtTokenService");

//     req["userId"] = jwtService.verifyAccessToken(token);

//     next();
//   } catch (error) {
//     return res.status(error.statusCode).json({ message: error.message });
//   }
// }
