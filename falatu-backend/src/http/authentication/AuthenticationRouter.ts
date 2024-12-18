// // dule = 'auth';
// //   const router = Router();

// //   const controller = container.resolve<AuthenticationController>(
// //     AuthenticationControllerImpl,
// //   );

// //   router.post(
// //     ApiHelper.getPublicUrl({ module }),
// //     validateSignInCredentials,
// //     async (req: Request, res: Response) => {
// //       return controller.signIn(req, res);
// //     },
// //   );

// //   return router;
// // }import { Request, Response, Router } from 'express';
// import {
//   AuthenticationController,
//   AuthenticationControllerImpl,
// } from './controllers/AuthenticationController';
// import { ApiHelper } from '../../utils/helpers/ApiHelper';
// import { validateSignInCredentials } from './middlewares/AuthenticationMiddlewares';

// export default function AuthenticationRouter() {
//   const mo
