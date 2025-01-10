"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CustomValidationPipe = void 0;
const common_1 = require("@nestjs/common");
const AppError_1 = require("../result/AppError");
class CustomValidationPipe extends common_1.ValidationPipe {
    constructor() {
        super({
            exceptionFactory: (errors) => {
                const firstError = errors[0];
                const message = Object.values(firstError.constraints || {}).shift();
                throw new AppError_1.BadRequestError(message);
            },
        });
    }
}
exports.CustomValidationPipe = CustomValidationPipe;
//# sourceMappingURL=custom_validation.pipe.js.map