import {
  IsEmail,
  IsStrongPassword,
  Length,
} from "class-validator";
import { Match } from "src/utils/validators/match";

export class CreateUserDTO {
  @IsEmail()
  email: string;

  @Length(5, 16)
  name: string;

  @IsStrongPassword()
  password: string;

  @IsStrongPassword()
  @Match(CreateUserDTO, (s) => s.password, {
    message: "passwords does not match.",
  })
  confirmPassword: string;

  picture: Express.Multer.File;
}
