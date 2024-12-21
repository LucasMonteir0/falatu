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
Object.defineProperty(exports, "__esModule", { value: true });
exports.PrismaAuthDatasourceImpl = void 0;
const bcryptjs_1 = require("bcryptjs");
const ResultWrapper_1 = require("../../../utils/result/ResultWrapper");
const AppError_1 = require("../../../utils/result/AppError");
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../../../utils/config/database/prisma.service");
const jwt_1 = require("@nestjs/jwt");
const constants_1 = require("../../commons/utils/constants");
let PrismaAuthDatasourceImpl = class PrismaAuthDatasourceImpl {
    constructor(jwtService, database) {
        this.jwtService = jwtService;
        this.database = database;
    }
    async signIn(credentials) {
        const user = await this.database.user.findUnique({
            where: { email: credentials.email },
        });
        if (!user) {
            const e = new AppError_1.NotFoundError("invalid e-mail or password");
            return ResultWrapper_1.ResultWrapper.error(e);
        }
        const { password, id } = user;
        const isPasswordValid = await (0, bcryptjs_1.compare)(credentials.password, password);
        if (!isPasswordValid) {
            const e = new AppError_1.UnauthorizedError("invalid e-mail or password");
            return ResultWrapper_1.ResultWrapper.error(e);
        }
        const payload = { sub: user.id, username: user.email };
        const access = await this.jwtService.signAsync(payload);
        const refresh = await this.jwtService.signAsync(payload, {
            expiresIn: "7d",
        });
        return ResultWrapper_1.ResultWrapper.success({
            uid: id,
            access,
            refresh,
        });
    }
    async refreshToken(token) {
        try {
            const payload = this.jwtService.verify(token, {
                secret: constants_1.jwtSecret,
            });
            const { sub, username } = payload;
            const access = await this.jwtService.signAsync({ sub, username });
            const refresh = await this.jwtService.signAsync({ sub, username }, {
                expiresIn: "7d",
            });
            return ResultWrapper_1.ResultWrapper.success({
                uid: sub,
                access,
                refresh,
            });
        }
        catch (e) {
            return ResultWrapper_1.ResultWrapper.error(new AppError_1.UnknownError(e));
        }
    }
};
exports.PrismaAuthDatasourceImpl = PrismaAuthDatasourceImpl;
exports.PrismaAuthDatasourceImpl = PrismaAuthDatasourceImpl = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [jwt_1.JwtService,
        prisma_service_1.PrismaService])
], PrismaAuthDatasourceImpl);
//# sourceMappingURL=prisma_auth.datasource.js.map