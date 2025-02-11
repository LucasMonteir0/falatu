import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class PrivateChatPage extends StatefulWidget {
  final String chatId;

  const PrivateChatPage({required this.chatId, super.key});

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  late final TextEditingController _textMessageController =
      TextEditingController();

  late final MessagesDatasource _datasource;
  late final SharedPreferencesService _preferences;
  late final Stream<List<MessageEntity>> _stream;

  @override
  void initState() {
    super.initState();
    _datasource = Modular.get<MessagesDatasource>();
    _preferences = Modular.get<SharedPreferencesService>();

    _stream = _datasource.loadMessages(widget.chatId);
  }

  @override
  void dispose() {
    _datasource.loadMessages(widget.chatId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final message = snapshot.data![index];
                          return Text(message.id);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  })),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(controller: _textMessageController))),
                IconButton(
                    onPressed: () {
                      final userId = _preferences.getUserId();
                      final message = SendMessageEntity(
                          senderId: userId!,
                          type: MessageType.text,
                          text: _textMessageController.text.trim());
                      _datasource.sendMessage(widget.chatId, message);

                      _textMessageController.clear();
                    },
                    icon: const Icon(Icons.send)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
