export class ApiHelper {
  private static handleUrl({
    module,
    path,
    params,
  }: {
    module: string;
    path?: string | null;
    params?: Array<string> | null;
  }): string {
    const formatted = !path ? "" : `/${path}`;
    let result = `/${module}${formatted}`;
    params?.forEach((value) => (result += `/:${value}`));
    return result;
  }

  public static getUrl({
    module,
    path,
    params,
  }: {
    module: string;
    path?: string | null;
    params?: Array<string> | null;
  }): string {
    return this.handleUrl({ module, path, params });
  }

  public static getPublicUrl({
    module,
    path = null,
    params = null,
  }: {
    module: string;
    path?: string | null;
    params?: Array<string> | null;
  }): string {
    return "/public" + this.handleUrl({ module, path, params });
  }
}
