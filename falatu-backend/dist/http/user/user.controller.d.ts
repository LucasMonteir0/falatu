import { UserEntity } from "src/http/commons/entities/user.entity";
import { UserDatasource } from "./datasources/user.datasource";
import { CreateUserDTO } from "./dtos/create_user.dto";
export declare class UserController {
    private readonly datasource;
    constructor(datasource: UserDatasource);
    createUser(picture: Express.Multer.File, body: CreateUserDTO): Promise<UserEntity>;
    getUsers(id?: string): Promise<UserEntity | UserEntity[]>;
}
