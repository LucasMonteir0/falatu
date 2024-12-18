import { UserDatasource } from "./user.datasource";
import { ResultWrapper } from "../../../utils/result/ResultWrapper";
import { UserEntity } from "src/http/commons/entities/user.entity";
import { CreateUserDTO } from "../dtos/create_user.dto";
export declare class PrismaUserDatasourceImpl implements UserDatasource {
    private readonly database;
    createUser(params: CreateUserDTO): Promise<ResultWrapper<UserEntity>>;
    getUserById(uid: string): Promise<ResultWrapper<UserEntity>>;
    getUsers(): Promise<ResultWrapper<UserEntity[]>>;
}
