import "../../core/domain/entities/base_error.dart";
import "errors.dart";

BaseError handleError(int? statusCode, {String message = "An error occurred"}) {
  final code = statusCode ?? -1;
  switch (code) {
    case 404:
      return NotFoundError(message: message);
    case 403:
      return ForBidenError(message: message);
    case 400:
      return BadRequestError(message: message);
    case 401:
      return UnauthorizedError(message: message);
    case 500:
      return InternalServerError(message: message);
    case 503:
      return ServiceUnavailableError(message: message);
    case 409:
      return ConflictError(message: message);
    case 422:
      return UnProcessableEntityError(message: message);
    case 429:
      return TooManyRequestsError(message: message);
    case 405:
      return MethodNotAllowedError(message: message);
    case 406:
      return NotAcceptableError(message: message);
    case 407:
      return ProxyAuthenticationRequiredError(message: message);
    case 408:
      return RequestTimeoutError(message: message);
    case 410:
      return GoneError(message: message);
    case 411:
      return LengthRequiredError(message: message);
    case 412:
      return PreconditionFailedError(message: message);
    case 413:
      return PayloadTooLargeError(message: message);
    case 414:
      return URITooLongError(message: message);
    case 415:
      return UnsupportedMediaTypeError(message: message);
    case 416:
      return RangeNotSatisfiableError(message: message);
    case 417:
      return ExpectationFailedError(message: message);
    case 421:
      return MisdirectedRequestError(message: message);
    case 426:
      return UpgradeRequiredError(message: message);
    case 428:
      return PreconditionRequiredError(message: message);
    case 511:
      return NetworkAuthenticationRequiredError(message: message);
    default:
      return UnknownError(message: message);
  }
}
