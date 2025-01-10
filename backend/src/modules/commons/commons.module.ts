import { Global, Module } from "@nestjs/common";
import { jwtSecret } from "../../utils/constants";
import { JwtModule } from "@nestjs/jwt";

@Global()
@Module({
  imports: [
    JwtModule.register({
      global: true,
      secret: jwtSecret,
      signOptions: { expiresIn: "1d" },
    }),
  ],
})
export class CommonsModule {}
