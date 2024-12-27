export declare class ApiHelper {
    private static handleUrl;
    static getUrl({ module, path, params, }: {
        module: string;
        path?: string | null;
        params?: Array<string> | null;
    }): string;
    static getPublicUrl({ module, path, params, }: {
        module: string;
        path?: string | null;
        params?: Array<string> | null;
    }): string;
}
