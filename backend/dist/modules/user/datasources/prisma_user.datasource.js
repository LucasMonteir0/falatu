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
exports.PrismaUserDatasourceImpl = void 0;
const bcryptjs_1 = require("bcryptjs");
const ResultWrapper_1 = require("../../../utils/result/ResultWrapper");
const AppError_1 = require("../../../utils/result/AppError");
const prisma_service_1 = require("../../../utils/config/database/prisma.service");
const user_entity_1 = require("../../commons/entities/user.entity");
const common_1 = require("@nestjs/common");
class PrismaUserDatasourceImpl {
    async createUser(params) {
        try {
            const emailExists = await this.database.user.findUnique({
                where: { email: params.email },
            });
            if (emailExists) {
                const error = new AppError_1.ConflictError("Email already in use.");
                return ResultWrapper_1.ResultWrapper.error(error);
            }
            const encryptedPassword = await (0, bcryptjs_1.hash)(params.password, 8);
            const user = await this.database.user.create({
                data: {
                    name: params.name,
                    email: params.email,
                    picture_url: null,
                    password: encryptedPassword,
                },
            });
            return ResultWrapper_1.ResultWrapper.success(user_entity_1.UserEntity.fromPrisma(user));
        }
        catch (e) {
            return ResultWrapper_1.ResultWrapper.error(e);
        }
    }
    async getUserById(uid) {
        try {
            const user = await this.database.user.findUnique({
                where: { id: uid },
            });
            if (!user) {
                const error = new AppError_1.NotFoundError("User not found.");
                return ResultWrapper_1.ResultWrapper.error(error);
            }
            return ResultWrapper_1.ResultWrapper.success(user_entity_1.UserEntity.fromPrisma(user));
        }
        catch (e) {
            return ResultWrapper_1.ResultWrapper.error(e);
        }
    }
    async getUsers() {
        try {
            const users = await this.database.user.findMany();
            const result = users.map((v) => user_entity_1.UserEntity.fromPrisma(v));
            return ResultWrapper_1.ResultWrapper.success(result);
        }
        catch (e) {
            return ResultWrapper_1.ResultWrapper.error(e);
        }
    }
}
exports.PrismaUserDatasourceImpl = PrismaUserDatasourceImpl;
__decorate([
    (0, common_1.Inject)(),
    __metadata("design:type", prisma_service_1.PrismaService)
], PrismaUserDatasourceImpl.prototype, "database", void 0);
//# sourceMappingURL=prisma_user.datasource.js.map