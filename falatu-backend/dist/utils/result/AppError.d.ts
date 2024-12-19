import { HttpException, HttpStatus } from "@nestjs/common";
export declare class AppError extends HttpException {
    private readonly statusCode;
    constructor(message: string, status: number);
    getResponse(): {
        status: HttpStatus;
        message: string;
    };
    static fromStatusCode(status: HttpStatus, message: string): AppError;
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
export declare class UnknownError extends AppError {
    constructor(message: string);
}
