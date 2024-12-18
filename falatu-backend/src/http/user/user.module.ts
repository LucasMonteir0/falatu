import { Module } from "@nestjs/common";
import { CommonsModule } from "../commons/commons.module";
import { UserController } from "./controllers/user.controller";
import { UserDatasource } from "./datasources/user.datasource";
import { PrismaUserDatasourceImpl } from "./datasources/prisma_user.datasource";

@Module({
  imports: [CommonsModule],
  controllers: [UserController],
  providers: [
    {
      provide: UserDatasource,
      useClass: PrismaUserDatasourceImpl,
    },
  ],
})
export class UserModule {}
