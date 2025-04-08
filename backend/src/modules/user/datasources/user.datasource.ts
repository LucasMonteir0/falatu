import { ResultWrapper } from "../../commons/utils/result/ResultWrapper";
import { UserEntity } from "../../commons/entities/user.entity";
import { CreateUserDTO } from "../dtos/create_user.dto";

export abstract class UserDatasource {
  abstract createUser(
    params: CreateUserDTO
  ): Promise<ResultWrapper<UserEntity>>;

  abstract getUserById(id: string): Promise<ResultWrapper<UserEntity>>;

  abstract getUsers(): Promise<ResultWrapper<Array<UserEntity>>>;

  abstract getNonFriends(
    userId: string
  ): Promise<ResultWrapper<Array<UserEntity>>>;
}
