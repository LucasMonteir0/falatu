import { Body, Controller, Post } from "@nestjs/common";
import { AuthDatasource } from "./datasources/auth.datasource";
import { SignInDTO } from "./dtos/sign_in.dto";
import { Public } from "../commons/utils/constants";

@Controller("auth")
export class AuthController {
  constructor(private readonly datasource: AuthDatasource) {}

  @Public()
  @Post()
  async signIn(@Body() body: SignInDTO): Promise<AuthResponseDTO> {
    const result = await this.datasource.signIn(body);
    if (result.isSuccess) {
      return result.data;
    }
    throw result.error;
  }

  @Public()
  @Post("refresh-token")
  async refreshToken(@Body() body: any): Promise<AuthResponseDTO> {
    const result = await this.datasource.refreshToken(body.token);
    if (result.isSuccess) {
      return result.data;
    }
    throw result.error;
  }
}
