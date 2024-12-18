"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CustomFilePipe = void 0;
const common_1 = require("@nestjs/common");
const AppError_1 = require("../result/AppError");
class CustomFilePipe extends common_1.ParseFilePipe {
    constructor(options) {
        super({
            exceptionFactory(error) {
                if (error.toLowerCase().search("type")) {
                    return new AppError_1.BadRequestError(`expected file type is ${options.fileType}`);
                }
                else if (error.toLowerCase().search("size")) {
                    return new AppError_1.BadRequestError(`expected maximum size is ${options.maxSize}`);
                }
                return new AppError_1.InternalError(error);
            },
            validators: [
                new common_1.MaxFileSizeValidator({ maxSize: options.maxSize }),
                new common_1.FileTypeValidator({ fileType: options.fileType }),
            ],
        });
    }
}
exports.CustomFilePipe = CustomFilePipe;
//# sourceMappingURL=custom_file.pipe.js.map