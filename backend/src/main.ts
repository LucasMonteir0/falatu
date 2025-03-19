import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";
import { CustomValidationPipe } from "./utils/pipes/custom_validation.pipe";
import { processDatabaseUrl } from "./utils/config/database/database.config";
import { dotEnvConfig } from "./utils/config/dotenv.config";

dotEnvConfig();

processDatabaseUrl();

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new CustomValidationPipe());
  await app.listen(process.env.HOST_PORT ?? 3333);
}
bootstrap();
