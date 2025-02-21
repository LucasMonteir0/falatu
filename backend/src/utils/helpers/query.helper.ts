export class QueryHelper {
  static includesOnChat() {
    return {
      userChats: {
        include: { user: true },
      },
      lastMessage: {
        include: {
          sender: true,
          messageReads: QueryHelper.includeReadsWithUser(),
        },
      },
    };
  }

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
    };
  } {
    return {
      include: {
        user: true,
      },
    };
  }
}
