"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserModule = void 0;
const common_1 = require("@nestjs/common");
const commons_module_1 = require("../commons/commons.module");
const user_controller_1 = require("./controllers/user.controller");
const user_datasource_1 = require("./datasources/user.datasource");
const prisma_user_datasource_1 = require("./datasources/prisma_user.datasource");
let UserModule = class UserModule {
};
exports.UserModule = UserModule;
exports.UserModule = UserModule = __decorate([
    (0, common_1.Module)({
        imports: [commons_module_1.CommonsModule],
        controllers: [user_controller_1.UserController],
        providers: [
            {
                provide: user_datasource_1.UserDatasource,
                useClass: prisma_user_datasource_1.PrismaUserDatasourceImpl,
            },
        ],
    })
], UserModule);
//# sourceMappingURL=user.module.js.map