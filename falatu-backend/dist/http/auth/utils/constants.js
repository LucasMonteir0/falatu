"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Public = exports.IS_PUBLIC_KEY = exports.jwtSecret = void 0;
const common_1 = require("@nestjs/common");
exports.jwtSecret = "welkqwpoekpqwoke qpo ekoqp";
exports.IS_PUBLIC_KEY = "isPublic";
const Public = () => (0, common_1.SetMetadata)(exports.IS_PUBLIC_KEY, true);
exports.Public = Public;
//# sourceMappingURL=constants.js.map