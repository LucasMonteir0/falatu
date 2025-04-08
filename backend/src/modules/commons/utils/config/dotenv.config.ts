import * as dotenv from "dotenv";

export const dotEnvConfig = () => dotenv.config({
  path: `.env.${process.env.APP_ENV || "local"}`,
});