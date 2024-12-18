// import { Controller } from "@nestjs/common";
// import { AuthenticationDatasource } from "../datasources/AuthenticationDatasource";


// @Controller()
// export class AuthenticationControllerImpl {
//   constructor(
//     private datasource: AuthenticationDatasource
//   ) {}

//   async signIn(req, res): Promise<UserAuthenticationTokensEntity> {
//     const { email, password } = req.body;
//     const result = await this.datasource.signIn({ login: email, password });

//     if (result.isSuccess) {
//       res.statusCode = 201;
//       res.json(result.data);
//     } else {
//       const error = result.error!;
//       res.status(error.status).send({ message: error.message });
//     }
//   }
// }
