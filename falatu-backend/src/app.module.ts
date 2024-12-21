import { Module } from "@nestjs/common";
import { UserModule } from "./http/user/user.module";
import { CommonsModule } from "./http/commons/commons.module";
import { DatabaseModule } from "./utils/config/database/database.module";
import { AuthModule } from "./http/auth/auth.module";
import { APP_GUARD } from "@nestjs/core";
import { AuthGuard } from "./http/commons/guards/auth.guard";
import { ChatModule } from "./http/chat/chat.module";

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
