import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource.dart";
import "package:falatu_mobile/chat/core/data/models/chat/private_chat_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/private_chat_entity.dart";
import "package:falatu_mobile/chat/ui/components/chat_tile.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/ui/blocs/sign_out_bloc.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late final ChatDatasource _datasource;
  // late final Stream<List<ChatEntity>> _stream;

  @override
  void initState() {
    _datasource = Modular.get();
    // _stream = _datasource.loadChats();
    super.initState();
  }

  String get _myId => Modular.get<SharedPreferencesService>().getUserId()!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Modular.get<SignOutBloc>().call(),
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ))
        ],
      ),
      // body: StreamBuilder(
      //   stream: _stream,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData && snapshot.data != null) {
      //       final chats = snapshot.data!;
      //
      //       return Column(
      //           children: snapshot.data!.map<Widget>((e) {
      //         switch (e.type) {
      //           case ChatType.private:
      //             final chat = e as PrivateChatModel;
      //             return ChatTile(
      //               title: e.otherUser.name,
      //               pictureUrl: e.otherUser.pictureUrl,
      //               onTap: () {
      //                 Modular.to.pushNamed(Routes.chats + Routes.privateChat,
      //                     arguments: e.id);
      //               },
      //             );
      //           case ChatType.group:
      //             return Text("${e.id} ${e.type.name}");
      //         }
      //       }).toList());
      //     }
      //     return Text('Sem chats');
      //   },
      // ),
    );
  }
}
