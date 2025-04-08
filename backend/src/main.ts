import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";
import { CustomValidationPipe } from "./modules/commons/utils/pipes/custom_validation.pipe";
import { processDatabaseUrl } from "./modules/commons/utils/config/database/database.config";
import { dotEnvConfig } from "./modules/commons/utils/config/dotenv.config";

dotEnvConfig();

processDatabaseUrl();

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new CustomValidationPipe());
  await app.listen(process.env.HOST_PORT ?? 3333);
}
bootstrap();
