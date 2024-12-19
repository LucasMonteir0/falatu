import { Module } from "@nestjs/common";
import { CommonsModule } from "../commons/commons.module";
import { UserDatasource } from "./datasources/user.datasource";
import { PrismaUserDatasourceImpl } from "./datasources/prisma_user.datasource";
import { UserController } from "./user.controller";

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
