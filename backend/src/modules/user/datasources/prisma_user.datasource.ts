import { UserDatasource } from "./user.datasource";
import { hash } from "bcryptjs";
import { ResultWrapper } from "../../../utils/result/ResultWrapper";
import { ConflictError, NotFoundError } from "../../../utils/result/AppError";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { UserEntity } from "../../commons/entities/user.entity";
import { CreateUserDTO } from "../dtos/create_user.dto";
import { Inject } from "@nestjs/common";
import {
  BucketOptions,
  BucketService,
} from "src/utils/config/bucket/bucket.service";

export class PrismaUserDatasourceImpl implements UserDatasource {
  @Inject()
  private readonly database: PrismaService;

  @Inject()
  private readonly bucket: BucketService;

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

      let user = await this.database.$transaction(async (transaction) => {
        let user = await transaction.user.create({
          data: {
            name: params.name,
            email: params.email,
            picture_url: null,
            password: encryptedPassword,
          },
        });

        if (params.picture) {
          const fileParts = params.picture.originalname.split(".");
          const extension = fileParts[fileParts.length - 1];
          const now = new Date();

          const bucketOptions: BucketOptions = {
            path: `users/${user.id}`,
            fileName: `profile_picture-${now.toISOString()}`,
            extension: extension,
            file: params.picture,
          };

          const pictureUrl = await this.bucket.uploadFile(bucketOptions);

          user = await transaction.user.update({
            where: {
              email: params.email,
            },
            data: {
              picture_url: pictureUrl,
            },
          });
        }

        return user;
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
