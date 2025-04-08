import { ValidationPipe } from "@nestjs/common";
import { BadRequestError } from "../result/AppError";

export class CustomValidationPipe extends ValidationPipe {
  constructor() {
    super({
      exceptionFactory: (errors) => {
        const firstError = errors[0];
        const message = Object.values(firstError.constraints || {}).shift();
        throw new BadRequestError(message);
      },
    });
  }
}
