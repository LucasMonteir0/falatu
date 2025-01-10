"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UnknownError = exports.InternalError = exports.ConflictError = exports.NotFoundError = exports.ForbiddenError = exports.UnauthorizedError = exports.BadRequestError = exports.AppError = void 0;
const common_1 = require("@nestjs/common");
class AppError extends common_1.HttpException {
    constructor(message, status) {
        super(message, status);
        this.statusCode = status;
        Object.setPrototypeOf(this, new.target.prototype);
        Error.captureStackTrace(this);
        console.error(`ERROR\n[name] ${this.name}\n[status] ${status}\n[message] ${this.message}`);
    }
    getResponse() {
        return {
            status: this.statusCode,
            message: this.message,
        };
    }
    static fromStatusCode(status, message) {
        switch (status) {
            case common_1.HttpStatus.BAD_REQUEST:
                return new BadRequestError(message);
            case common_1.HttpStatus.UNAUTHORIZED:
                return new UnauthorizedError(message);
            case common_1.HttpStatus.FORBIDDEN:
                return new ForbiddenError(message);
            case common_1.HttpStatus.NOT_FOUND:
                return new NotFoundError(message);
            case common_1.HttpStatus.CONFLICT:
                return new ConflictError(message);
            case common_1.HttpStatus.INTERNAL_SERVER_ERROR:
                return new InternalError(message);
            default:
                return new UnknownError(message);
        }
    }
}
exports.AppError = AppError;
class BadRequestError extends AppError {
    constructor(message) {
        super(message, common_1.HttpStatus.BAD_REQUEST);
    }
}
exports.BadRequestError = BadRequestError;
class UnauthorizedError extends AppError {
    constructor(message) {
        super(message, common_1.HttpStatus.UNAUTHORIZED);
    }
}
exports.UnauthorizedError = UnauthorizedError;
class ForbiddenError extends AppError {
    constructor(message) {
        super(message, common_1.HttpStatus.FORBIDDEN);
    }
}
exports.ForbiddenError = ForbiddenError;
class NotFoundError extends AppError {
    constructor(message) {
        super(message, common_1.HttpStatus.NOT_FOUND);
    }
}
exports.NotFoundError = NotFoundError;
class ConflictError extends AppError {
    constructor(message) {
        super(message, common_1.HttpStatus.CONFLICT);
    }
}
exports.ConflictError = ConflictError;
class InternalError extends AppError {
    constructor(message) {
        super(message, common_1.HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
exports.InternalError = InternalError;
class UnknownError extends AppError {
    constructor(message) {
        super(message, 0);
    }
}
exports.UnknownError = UnknownError;
//# sourceMappingURL=AppError.js.map