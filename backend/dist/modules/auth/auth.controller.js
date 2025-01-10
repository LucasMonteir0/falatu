"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthController = void 0;
const common_1 = require("@nestjs/common");
const auth_datasource_1 = require("./datasources/auth.datasource");
const sign_in_dto_1 = require("./dtos/sign_in.dto");
const constants_1 = require("../../utils/constants");
let AuthController = class AuthController {
    constructor(datasource) {
        this.datasource = datasource;
    }
    async signIn(body) {
        const result = await this.datasource.signIn(body);
        if (result.isSuccess) {
            return result.data;
        }
        throw result.error;
    }
    async refreshToken(body) {
        const result = await this.datasource.refreshToken(body.token);
        if (result.isSuccess) {
            return result.data;
        }
        throw result.error;
    }
};
exports.AuthController = AuthController;
__decorate([
    (0, constants_1.Public)(),
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [sign_in_dto_1.SignInDTO]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "signIn", null);
__decorate([
    (0, constants_1.Public)(),
    (0, common_1.Post)("refresh-token"),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "refreshToken", null);
exports.AuthController = AuthController = __decorate([
    (0, common_1.Controller)("auth"),
    __metadata("design:paramtypes", [auth_datasource_1.AuthDatasource])
], AuthController);
//# sourceMappingURL=auth.controller.js.map