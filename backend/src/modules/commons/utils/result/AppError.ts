import { HttpException, HttpStatus } from "@nestjs/common";

export class AppError extends HttpException {
  private readonly statusCode: HttpStatus;

  constructor(message: string, status: number) {
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

  static fromStatusCode(status: HttpStatus, message: string): AppError {
    switch (status) {
      case HttpStatus.BAD_REQUEST:
        return new BadRequestError(message);
      case HttpStatus.UNAUTHORIZED:
        return new UnauthorizedError(message);
      case HttpStatus.FORBIDDEN:
        return new ForbiddenError(message);
      case HttpStatus.NOT_FOUND:
        return new NotFoundError(message);
      case HttpStatus.CONFLICT:
        return new ConflictError(message);
      case HttpStatus.INTERNAL_SERVER_ERROR:
        return new InternalError(message);
      default:
        return new UnknownError(message);
    }
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

export class UnknownError extends AppError {
  constructor(message: string) {
    super(message, 0);
  }
}
