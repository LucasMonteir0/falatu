import { Module } from "@nestjs/common";
import { UserModule } from "./http/user/user.module";
import { CommonsModule } from "./http/commons/commons.module";
import { DatabaseModule } from "./config/database/database.module";

@Module({
  imports: [UserModule, CommonsModule, DatabaseModule],
})
export class AppModule {}
