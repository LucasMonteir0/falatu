"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.QueryHelper = void 0;
class QueryHelper {
    static selectUser() {
        return {
            select: {
                id: true,
                name: true,
                email: true,
                picture_url: true,
                createdAt: true,
            },
        };
    }
}
exports.QueryHelper = QueryHelper;
//# sourceMappingURL=query.helper.js.map