import { FileInterceptor } from "@nestjs/platform-express";
import {
  Body,
  Controller,
  Get,
  Post,
  Query,
  UploadedFile,
  UseInterceptors,
} from "@nestjs/common";
import { UserEntity } from "src/modules/commons/entities/user.entity";
import { CustomFilePipe } from "src/utils/pipes/custom_file.pipe";
import { UserDatasource } from "./datasources/user.datasource";
import { CreateUserDTO } from "./dtos/create_user.dto";

const MAX_SIZE: number = 5 * 1024 * 1024;

@Controller("/users")
export class UserController {
  constructor(private readonly datasource: UserDatasource) {}

  @Post()
  @UseInterceptors(FileInterceptor("picture"))
  public async createUser(
    @UploadedFile(
      new CustomFilePipe({
        maxSize: MAX_SIZE,
        fileType: /image\/(jpeg|jpg|png)/,
      })
    )
    picture: Express.Multer.File,
    @Body() body: CreateUserDTO
  ): Promise<UserEntity> {
    const user: CreateUserDTO = { ...body, picture };
    const result = await this.datasource.createUser(user);
    if (result.isSuccess) {
      return result.data;
    }
    throw result.error;
  }

  @Get()
  public async getUsers(
    @Query("id") id?: string
  ): Promise<UserEntity | UserEntity[]> {
    if (id) {
      const result = await this.datasource.getUserById(id);
      if (result.isSuccess) {
        return result.data;
      }
      throw result.error;
    }

    const result = await this.datasource.getUsers();
    if (result.isSuccess) {
      return result.data;
    }
    throw result.error;
  }
}
