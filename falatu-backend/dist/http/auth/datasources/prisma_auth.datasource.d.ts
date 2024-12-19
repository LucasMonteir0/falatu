import { ResultWrapper } from "../../../utils/result/ResultWrapper";
import { AuthDatasource } from "./auth.datasource";
import { SignInDTO } from "../dtos/sign_in.dto";
import { PrismaService } from "src/config/database/prisma.service";
import { JwtService } from "@nestjs/jwt";
export declare class PrismaAuthDatasourceImpl implements AuthDatasource {
    private readonly jwtService;
    private readonly database;
    constructor(jwtService: JwtService, database: PrismaService);
    signIn(credentials: SignInDTO): Promise<ResultWrapper<AuthResponseDTO>>;
    refreshToken(token: string): Promise<ResultWrapper<AuthResponseDTO>>;
}
