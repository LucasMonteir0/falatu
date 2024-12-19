import { AuthDatasource } from "./datasources/auth.datasource";
import { SignInDTO } from "./dtos/sign_in.dto";
export declare class AuthController {
    private readonly datasource;
    constructor(datasource: AuthDatasource);
    signIn(body: SignInDTO): Promise<AuthResponseDTO>;
    refreshToken(body: any): Promise<AuthResponseDTO>;
}
