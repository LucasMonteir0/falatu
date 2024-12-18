import { ParseFilePipe } from "@nestjs/common";
export interface CustomFilePipeOptions {
    maxSize: number;
    fileType: string | RegExp;
}
export declare class CustomFilePipe extends ParseFilePipe {
    constructor(options: CustomFilePipeOptions);
}
