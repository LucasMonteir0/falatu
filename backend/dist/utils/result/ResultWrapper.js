"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ResultWrapper = void 0;
class ResultWrapper {
    constructor(isSuccess, error, data) {
        this.isSuccess = isSuccess;
        this.error = error;
        this.data = data;
    }
    static success(data) {
        return new ResultWrapper(true, null, data || null);
    }
    static error(error) {
        return new ResultWrapper(false, error, null);
    }
}
exports.ResultWrapper = ResultWrapper;
//# sourceMappingURL=ResultWrapper.js.map