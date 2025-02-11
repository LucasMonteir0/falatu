import "dart:convert";

import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource.dart";
import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource_impl.dart";
import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource.dart";
import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource_impl.dart";
import "package:falatu_mobile/chat/ui/pages/chats_page.dart";
import "package:falatu_mobile/chat/ui/pages/private_chat_page.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter_modular/flutter_modular.dart";

class ChatModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<ChatDatasource>(
          (i) => ChatDatasourceImpl(i()),
          onDispose: (datasource) => datasource.dispose(),
        ),
        Bind.lazySingleton<MessagesDatasource>(
          (i) => MessagesDatasourceImpl(i()),
          onDispose: (datasource) => datasource.dispose(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Routes.root, child: (_, __) => const ChatsPage()),
        ChildRoute(Routes.privateChat,
            child: (_, args) => PrivateChatPage(chatId: args.data)),
      ];
}
