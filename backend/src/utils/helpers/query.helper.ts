export class QueryHelper {
  static selectUser(): {
    select: {
      id: boolean;
      name: boolean;
      email: boolean;
      picture_url: boolean;
      createdAt: boolean;
    };
  } {
    return {
      select: {
        id: true,
        name: true,
        email: true,
        picture_url: true,
        createdAt: true,
      },
    };
  }
  static includeReadsWithUser(): {
    include: {
      user: boolean;
      readAt: boolean;
    };
  } {
    return {
      include: {
        user: true,
        readAt: true,
      },
    };
  }
}
