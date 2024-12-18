// import { NextFunction, Request, Response } from "express";
// import { CreateUserSchema } from "../entities/CreateUserEntity";
// import { BadRequestError } from "../../../utils/result/AppError";

// export const validateUser = (
//   req: Request,
//   res: Response,
//   next: NextFunction
// ) => {
//   const picture: Express.Multer.File | undefined = req.file;
//   if (!picture) {
//     const errorMessage = "Picture is required.";
//     const error = new BadRequestError(errorMessage);
//     return res.status(error.status).json({ message: error.message });
//   }

//   const schema = {
//     email: req.body.email,
//     username: req.body.username,
//     password: req.body.password,
//     picture: picture,
//     colorHex: req.body.colorHex,
//     confirmPassword: req.body.confirmPassword,
//   };

//   const validation = CreateUserSchema.safeParse(schema);

//   if (!validation.success) {
//     const errorMessage = validation.error.errors[0].message;
//     const error = new BadRequestError(errorMessage); // Use custom error class or return directly
//     return res.status(error.status).json({ message: error.message });
//   }
//   next();
// };
