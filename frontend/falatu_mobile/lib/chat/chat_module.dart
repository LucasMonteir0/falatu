import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource.dart";
import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource_impl.dart";
import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource.dart";
import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource_impl.dart";
import "package:falatu_mobile/chat/core/data/repositories/chat/chat_repository_impl.dart";
import "package:falatu_mobile/chat/core/data/repositories/messages/messages_repository_impl.dart";
import "package:falatu_mobile/chat/core/domain/repositories/chat/chat_repository.dart";
import "package:falatu_mobile/chat/core/domain/repositories/messages/messages_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/load_chats/load_chats_use_case.dart";
import "package:falatu_mobile/chat/core/domain/usecases/load_chats/load_chats_use_case_impl.dart";
import "package:falatu_mobile/chat/core/domain/usecases/load_messages/load_messages_use_case.dart";
import "package:falatu_mobile/chat/core/domain/usecases/load_messages/load_messages_use_case_impl.dart";
import "package:falatu_mobile/chat/core/domain/usecases/send_message/send_message_use_case.dart";
import "package:falatu_mobile/chat/core/domain/usecases/update_last_message/update_last_message_use_case.dart";
import "package:falatu_mobile/chat/core/domain/usecases/update_last_message/update_last_message_use_case_impl.dart";
import "package:falatu_mobile/chat/ui/blocs/load_chats/load_chats_bloc.dart";
import "package:falatu_mobile/chat/ui/blocs/load_messages/load_messages_bloc.dart";
import "package:falatu_mobile/chat/ui/blocs/send_message/send_messge_bloc.dart";
import "package:falatu_mobile/chat/ui/pages/chats_page.dart";
import "package:falatu_mobile/chat/ui/pages/private_chat_page.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter_modular/flutter_modular.dart";

import "core/domain/usecases/send_message/send_message_use_case_impl.dart";

class ChatModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //DATASOURCES
        Bind.factory<ChatDatasource>((i) => ChatDatasourceImpl(i(), i())),
        Bind.factory<MessagesDatasource>(
            (i) => MessagesDatasourceImpl(i(), i())),

        //REPOSITORIES
        Bind.factory<ChatRepository>((i) => ChatRepositoryImpl(i())),
        Bind.factory<MessagesRepository>((i) => MessagesRepositoryImpl(i())),

        //USECASES
        Bind.factory<LoadChatsUseCase>((i) => LoadChatsUseCaseImpl(i())),
        Bind.factory<LoadMessagesUseCase>((i) => LoadMessagesUseCaseImpl(i())),
        Bind.factory<SendMessageUseCase>((i) => SendMessageUseCaseImpl(i())),
        Bind.factory<UpdateLastMessageUseCase>((i) => UpdateLastMessageUseCaseImpl(i())),

        //BLOCS
        Bind.lazySingleton<LoadChatsBloc>((i) => LoadChatsBloc(i())),
        Bind.factory<LoadMessagesBloc>((i) => LoadMessagesBloc(i())),
        Bind.factory<SendMessageBloc>((i) => SendMessageBloc(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Routes.root, child: (_, __) => const ChatsPage()),
        ChildRoute(Routes.privateChat,
            child: (_, args) => PrivateChatPage(chat: args.data)),
      ];
}
