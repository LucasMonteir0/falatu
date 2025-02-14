import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource.dart";
import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource_impl.dart";
import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource.dart";
import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource_impl.dart";
import "package:falatu_mobile/chat/core/data/repositories/chat/chat_repository_impl.dart";
import "package:falatu_mobile/chat/core/domain/repositories/chat/chat_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/load_chats/load_chats_use_case.dart";
import "package:falatu_mobile/chat/core/domain/usecases/load_chats/load_chats_use_case_impl.dart";
import "package:falatu_mobile/chat/ui/blocs/load_chats/load_chats_bloc.dart";
import "package:falatu_mobile/chat/ui/pages/chats_page.dart";
import "package:falatu_mobile/chat/ui/pages/private_chat_page.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter_modular/flutter_modular.dart";

class ChatModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<ChatDatasource>((i) => ChatDatasourceImpl(i(), i()),
            onDispose: (datasource) => datasource.dispose()),
        Bind.factory<MessagesDatasource>((i) => MessagesDatasourceImpl(i())),
        Bind.factory<ChatRepository>((i) => ChatRepositoryImpl(i())),
        Bind.factory<LoadChatsUseCase>((i) => LoadChatsUseCaseImpl(i())),
        Bind.factory<LoadChatsBloc>((i) => LoadChatsBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Routes.root, child: (_, __) => const ChatsPage()),
        ChildRoute(Routes.privateChat,
            child: (_, args) => PrivateChatPage(chatId: args.data)),
      ];
}
