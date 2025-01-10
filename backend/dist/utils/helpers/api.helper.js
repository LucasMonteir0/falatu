"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ApiHelper = void 0;
class ApiHelper {
    static handleUrl({ module, path, params, }) {
        const formatted = !path ? "" : `/${path}`;
        let result = `/${module}${formatted}`;
        params?.forEach((value) => (result += `/:${value}`));
        return result;
    }
    static getUrl({ module, path, params, }) {
        return this.handleUrl({ module, path, params });
    }
    static getPublicUrl({ module, path = null, params = null, }) {
        return "/public" + this.handleUrl({ module, path, params });
    }
}
exports.ApiHelper = ApiHelper;
//# sourceMappingURL=api.helper.js.map