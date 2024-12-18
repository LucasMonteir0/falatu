import { AppError } from "./AppError";
export declare class ResultWrapper<T> {
    isSuccess: boolean;
    error: AppError | null;
    data: T | null;
    private constructor();
    static success<T>(data: T): ResultWrapper<T>;
    static error<U>(error: AppError): ResultWrapper<U>;
}
