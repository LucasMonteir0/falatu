import { HttpException, HttpStatus } from "@nestjs/common";

export class AppError extends HttpException {
  public statusCode: HttpStatus;

  constructor(message: string, status: HttpStatus) {
    super(message, status);
    this.statusCode = status;

    Object.setPrototypeOf(this, new.target.prototype);
    Error.captureStackTrace(this);

    console.error(
      `ERROR\n[name] ${this.name}\n[status] ${status}\n[message] ${this.message}`
    );
  }

  getResponse() {
    return {
      status: this.statusCode,
      message: this.message,
    };
  }
}

export class BadRequestError extends AppError {
  constructor(message: string) {
    super(message, HttpStatus.BAD_REQUEST);
  }
}

export class UnauthorizedError extends AppError {
  constructor(message: string) {
    super(message, HttpStatus.UNAUTHORIZED);
  }
}

export class ForbiddenError extends AppError {
  constructor(message: string) {
    super(message, HttpStatus.FORBIDDEN);
  }
}

export class NotFoundError extends AppError {
  constructor(message: string) {
    super(message, HttpStatus.NOT_FOUND);
  }
}

export class ConflictError extends AppError {
  constructor(message: string) {
    super(message, HttpStatus.CONFLICT);
  }
}

export class InternalError extends AppError {
  constructor(message: string) {
    super(message, HttpStatus.INTERNAL_SERVER_ERROR);
  }
}
