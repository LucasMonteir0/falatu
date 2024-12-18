import { HttpException, HttpStatus } from "@nestjs/common";
export declare class AppError extends HttpException {
    statusCode: HttpStatus;
    constructor(message: string, status: HttpStatus);
    getResponse(): {
        status: HttpStatus;
        message: string;
    };
}
export declare class BadRequestError extends AppError {
    constructor(message: string);
}
export declare class UnauthorizedError extends AppError {
    constructor(message: string);
}
export declare class ForbiddenError extends AppError {
    constructor(message: string);
}
export declare class NotFoundError extends AppError {
    constructor(message: string);
}
export declare class ConflictError extends AppError {
    constructor(message: string);
}
export declare class InternalError extends AppError {
    constructor(message: string);
}
