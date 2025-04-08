import {
  FileTypeValidator,
  MaxFileSizeValidator,
  ParseFilePipe,
} from "@nestjs/common";
import { BadRequestError, InternalError } from "../result/AppError";

export interface CustomFilePipeOptions {
  maxSize: number;
  fileType: string | RegExp;
  fileIsRequired?: boolean;
}

export class CustomFilePipe extends ParseFilePipe {
  constructor(options: CustomFilePipeOptions) {
    super({
      exceptionFactory(error) {
        if (error.toLowerCase().search("type")) {
          return new BadRequestError(
            `expected file type is ${options.fileType}`
          );
        } else if (error.toLowerCase().search("size")) {
          return new BadRequestError(
            `expected maximum size is ${options.maxSize}`
          );
        }
        return new InternalError(error);
      },
      validators: [
        new MaxFileSizeValidator({ maxSize: options.maxSize }),
        new FileTypeValidator({ fileType: options.fileType }),
      ],
      fileIsRequired: options.fileIsRequired ?? true,
    });
  }
}
