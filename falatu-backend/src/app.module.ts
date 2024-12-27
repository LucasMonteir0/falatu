import { Module } from "@nestjs/common";
import { UserModule } from "./modules/user/user.module";
import { CommonsModule } from "./modules/commons/commons.module";
import { DatabaseModule } from "./utils/config/database/database.module";
import { AuthModule } from "./modules/auth/auth.module";
import { APP_GUARD } from "@nestjs/core";
import { AuthGuard } from "./modules/commons/guards/auth.guard";
import { ChatModule } from "./modules/chat/chat.module";

@Module({
  imports: [UserModule, CommonsModule, DatabaseModule, AuthModule, ChatModule],
  providers: [
    {
      provide: APP_GUARD,
      useClass: AuthGuard,
    },
  ],
})
export class AppModule {}
