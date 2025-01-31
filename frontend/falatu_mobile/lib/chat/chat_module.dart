import "package:falatu_mobile/chat/ui/pages/chats_page.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter_modular/flutter_modular.dart";

class ChatModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Routes.root, child: (_, __) => const ChatsPage()),
      ];
}
