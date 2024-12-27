import { Module } from "@nestjs/common";
import { AuthDatasource } from "./datasources/auth.datasource";
import { PrismaAuthDatasourceImpl } from "./datasources/prisma_auth.datasource";
import { AuthController } from "./auth.controller";

@Module({
  imports: [

  ],
  providers: [
    {
      provide: AuthDatasource,
      useClass: PrismaAuthDatasourceImpl,
    },
  ],
  controllers: [AuthController],
  exports: [],
})
export class AuthModule {}
