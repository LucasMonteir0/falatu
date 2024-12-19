import { Module } from "@nestjs/common";
import { JwtModule } from "@nestjs/jwt";
import { AuthDatasource } from "./datasources/auth.datasource";
import { PrismaAuthDatasourceImpl } from "./datasources/prisma_auth.datasource";
import { AuthController } from "./auth.controller";
import { jwtSecret } from "./utils/constants";

@Module({
  imports: [
    JwtModule.register({
      global: true,
      secret: jwtSecret,
      signOptions: { expiresIn: "3s" },
    }),
  ],
  providers: [
    {
      provide: AuthDatasource,
      useClass: PrismaAuthDatasourceImpl,
    },
  ],
  controllers: [AuthController],
  exports: [AuthDatasource],
})
export class AuthModule {}
