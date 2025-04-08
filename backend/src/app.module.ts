import { Module } from "@nestjs/common";
import { UserModule } from "./modules/user/user.module";
import { CommonsModule } from "./modules/commons/commons.module";
import { DatabaseModule } from "./modules/commons/utils/config/database/database.module";
import { AuthModule } from "./modules/auth/auth.module";
import { APP_GUARD } from "@nestjs/core";
import { ChatModule } from "./modules/chat/chat.module";
import { BucketModule } from "./modules/commons/utils/config/bucket/bucket.module";
import { AuthGuard } from "./modules/commons/utils/guards/auth.guard";

@Module({
  imports: [
    UserModule,
    CommonsModule,
    BucketModule,
    DatabaseModule,
    AuthModule,
    ChatModule,
  ],
  providers: [
    {
      provide: APP_GUARD,
      useClass: AuthGuard,
    },
  ],
})
export class AppModule {}
