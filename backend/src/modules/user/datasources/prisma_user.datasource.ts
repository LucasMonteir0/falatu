import { UserDatasource } from "./user.datasource";
import { hash } from "bcryptjs";
import { ResultWrapper } from "../../../utils/result/ResultWrapper";
import { ConflictError, NotFoundError } from "../../../utils/result/AppError";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { UserEntity } from "src/modules/commons/entities/user.entity";
import { CreateUserDTO } from "../dtos/create_user.dto";
import { Inject } from "@nestjs/common";

export class PrismaUserDatasourceImpl implements UserDatasource {
  @Inject()
  private readonly database: PrismaService;

  async createUser(params: CreateUserDTO): Promise<ResultWrapper<UserEntity>> {
    try {
      const emailExists = await this.database.user.findUnique({
        where: { email: params.email },
      });

      if (emailExists) {
        const error = new ConflictError("Email already in use.");

        return ResultWrapper.error(error);
      }

      const encryptedPassword = await hash(params.password, 8);

      const user = await this.database.user.create({
        data: {
          name: params.name,
          email: params.email,
          picture_url: null, // TODO SAVE PICTURE
          password: encryptedPassword,
        },
      });

      return ResultWrapper.success(UserEntity.fromPrisma(user));
    } catch (e) {
      return ResultWrapper.error(e);
    }
  }

  async getUserById(uid: string): Promise<ResultWrapper<UserEntity>> {
    try {
      const user = await this.database.user.findUnique({
        where: { id: uid },
      });

      if (!user) {
        const error = new NotFoundError("User not found.");
        return ResultWrapper.error(error);
      }

      return ResultWrapper.success(UserEntity.fromPrisma(user));
    } catch (e) {
      return ResultWrapper.error(e);
    }
  }

  async getUsers(): Promise<ResultWrapper<UserEntity[]>> {
    try {
      const users = await this.database.user.findMany();

      const result: UserEntity[] = users.map((v) => UserEntity.fromPrisma(v));

      return ResultWrapper.success(result);
    } catch (e) {
      return ResultWrapper.error(e);
    }
  }
}
