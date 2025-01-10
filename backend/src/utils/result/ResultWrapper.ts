import { AppError } from "./AppError";

export class ResultWrapper<T> {
  public isSuccess: boolean;
  public error: AppError | null;
  public data: T | null;

  private constructor(
    isSuccess: boolean,
    error: AppError | null,
    data: T | null
  ) {
    this.isSuccess = isSuccess;
    this.error = error;
    this.data = data;
  }

  public static success<T>(data: T): ResultWrapper<T> {
    return new ResultWrapper<T>(true, null, data || null);
  }

  public static error<U>(error: AppError): ResultWrapper<U> {
    return new ResultWrapper<U>(false, error, null);
  }

}
