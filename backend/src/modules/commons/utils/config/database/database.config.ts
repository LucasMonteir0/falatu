import { dotEnvConfig } from "../dotenv.config";


dotEnvConfig();

const dbUser = process.env.DB_USER;
const dbPassword = process.env.DB_PASSWORD;
const dbHost = process.env.DB_HOST;
const dbPort = process.env.DB_PORT;
const dbName = process.env.DB_NAME;


export function processDatabaseUrl() {
  process.env.DATABASE_URL = process.env.DATABASE_URL.replace(
    "${DB_USER}",
    dbUser || ""
  )
    .replace("${DB_PASSWORD}", dbPassword || "")
    .replace("${DB_HOST}", dbHost || "")
    .replace("${DB_PORT}", dbPort || "")
    .replace("${DB_NAME}", dbName || "");
  
}

