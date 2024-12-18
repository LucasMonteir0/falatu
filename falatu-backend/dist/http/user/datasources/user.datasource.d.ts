import { ResultWrapper } from "../../../utils/result/ResultWrapper";
import { UserEntity } from "src/http/commons/entities/user.entity";
import { CreateUserDTO } from "../dtos/create_user.dto";
export declare abstract class UserDatasource {
    abstract createUser(params: CreateUserDTO): Promise<ResultWrapper<UserEntity>>;
    abstract getUserById(id: string): Promise<ResultWrapper<UserEntity>>;
    abstract getUsers(): Promise<ResultWrapper<Array<UserEntity>>>;
}
