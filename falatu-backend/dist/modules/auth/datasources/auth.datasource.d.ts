import { ResultWrapper } from "../../../utils/result/ResultWrapper";
import { SignInDTO } from "../dtos/sign_in.dto";
export declare abstract class AuthDatasource {
    abstract signIn(credentials: SignInDTO): Promise<ResultWrapper<AuthResponseDTO>>;
    abstract refreshToken(token: string): Promise<ResultWrapper<AuthResponseDTO>>;
}
