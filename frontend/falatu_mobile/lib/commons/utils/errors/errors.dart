import '../../core/domain/entities/base_error.dart';

class NotFoundError extends BaseError {
  NotFoundError({super.message = 'NotFoundError'}) : super(code: 404);

  @override
  List<Object?> get props => [message, code];
}

class ForBidenError extends BaseError {
  ForBidenError({super.message = 'ForBidenError'}) : super(code: 403);

  @override
  List<Object?> get props => [message, code];
}

class BadRequestError extends BaseError {
  BadRequestError({super.message = 'BadRequestError'}) : super(code: 400);

  @override
  List<Object?> get props => [message, code];
}

class UnauthorizedError extends BaseError {
  UnauthorizedError({super.message = 'UnauthorizedError'}) : super(code: 401);

  @override
  List<Object?> get props => [message, code];
}

class InternalServerError extends BaseError {
  InternalServerError({super.message = 'InternalServerError'})
      : super(code: 500);

  @override
  List<Object?> get props => [message, code];
}

class ServiceUnavailableError extends BaseError {
  ServiceUnavailableError({super.message = 'ServiceUnavailableError'})
      : super(code: 503);

  @override
  List<Object?> get props => [message, code];
}

class ConflictError extends BaseError {
  ConflictError({super.message = 'ConflictError'}) : super(code: 409);

  @override
  List<Object?> get props => [message, code];
}

class UnProcessableEntityError extends BaseError {
  UnProcessableEntityError({super.message = 'UnProcessableEntityError'})
      : super(code: 422);

  @override
  List<Object?> get props => [message, code];
}

class TooManyRequestsError extends BaseError {
  TooManyRequestsError({super.message = 'TooManyRequestsError'})
      : super(code: 429);

  @override
  List<Object?> get props => [message, code];
}

class UnknownError extends BaseError {
  UnknownError({super.message = 'UnknownError'}) : super(code: -1);

  @override
  List<Object?> get props => [message, code];
}

class MethodNotAllowedError extends BaseError {
  MethodNotAllowedError({super.message = 'MethodNotAllowedError'})
      : super(code: 405);

  @override
  List<Object?> get props => [message, code];
}

class NotAcceptableError extends BaseError {
  NotAcceptableError({super.message = 'NotAcceptableError'}) : super(code: 406);

  @override
  List<Object?> get props => [message, code];
}

class ProxyAuthenticationRequiredError extends BaseError {
  ProxyAuthenticationRequiredError(
      {super.message = 'ProxyAuthenticationRequiredError'})
      : super(code: 407);

  @override
  List<Object?> get props => [message, code];
}

class RequestTimeoutError extends BaseError {
  RequestTimeoutError({super.message = 'RequestTimeoutError'})
      : super(code: 408);

  @override
  List<Object?> get props => [message, code];
}

class GoneError extends BaseError {
  GoneError({super.message = 'GoneError'}) : super(code: 410);

  @override
  List<Object?> get props => [message, code];
}

class LengthRequiredError extends BaseError {
  LengthRequiredError({super.message = 'LengthRequiredError'})
      : super(code: 411);

  @override
  List<Object?> get props => [message, code];
}

class PreconditionFailedError extends BaseError {
  PreconditionFailedError({super.message = 'PreconditionFailedError'})
      : super(code: 412);

  @override
  List<Object?> get props => [message, code];
}

class PayloadTooLargeError extends BaseError {
  PayloadTooLargeError({super.message = 'PayloadTooLargeError'})
      : super(code: 413);

  @override
  List<Object?> get props => [message, code];
}

class URITooLongError extends BaseError {
  URITooLongError({super.message = 'URITooLongError'}) : super(code: 414);

  @override
  List<Object?> get props => [message, code];
}

class UnsupportedMediaTypeError extends BaseError {
  UnsupportedMediaTypeError({super.message = 'UnsupportedMediaTypeError'})
      : super(code: 415);

  @override
  List<Object?> get props => [message, code];
}

class RangeNotSatisfiableError extends BaseError {
  RangeNotSatisfiableError({super.message = 'RangeNotSatisfiableError'})
      : super(code: 416);

  @override
  List<Object?> get props => [message, code];
}

class ExpectationFailedError extends BaseError {
  ExpectationFailedError({super.message = 'ExpectationFailedError'})
      : super(code: 417);

  @override
  List<Object?> get props => [message, code];
}

class MisdirectedRequestError extends BaseError {
  MisdirectedRequestError({super.message = 'MisdirectedRequestError'})
      : super(code: 421);

  @override
  List<Object?> get props => [message, code];
}

class UpgradeRequiredError extends BaseError {
  UpgradeRequiredError({super.message = 'UpgradeRequiredError'})
      : super(code: 426);

  @override
  List<Object?> get props => [message, code];
}

class PreconditionRequiredError extends BaseError {
  PreconditionRequiredError({super.message = 'PreconditionRequiredError'})
      : super(code: 428);

  @override
  List<Object?> get props => [message, code];
}

class NetworkAuthenticationRequiredError extends BaseError {
  NetworkAuthenticationRequiredError(
      {super.message = 'NetworkAuthenticationRequiredError'})
      : super(code: 511);

  @override
  List<Object?> get props => [message, code];
}
