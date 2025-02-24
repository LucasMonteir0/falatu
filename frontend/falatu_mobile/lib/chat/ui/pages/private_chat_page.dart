import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/text_message_entity.dart";
import "package:falatu_mobile/chat/ui/blocs/load_messages/load_messages_bloc.dart";
import "package:falatu_mobile/chat/ui/blocs/load_messages/message_events.dart";
import "package:falatu_mobile/chat/ui/blocs/send_message/send_messge_bloc.dart";
import "package:falatu_mobile/chat/ui/components/messages/text_message_card.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/ui/blocs/update_access_token_bloc.dart";
import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
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

  late final LoadMessagesBloc _loadMessagesBloc;
  late final SendMessageBloc _sendMessageBloc;
  late final UpdateAccessTokenBloc _updateAccessTokenBloc;
  late final SharedPreferencesService _preferences;

  @override
  void initState() {
    super.initState();
    _loadMessagesBloc = Modular.get<LoadMessagesBloc>();
    _sendMessageBloc = Modular.get<SendMessageBloc>();
    _preferences = Modular.get<SharedPreferencesService>();

    _updateAccessTokenBloc = Modular.get<UpdateAccessTokenBloc>();

    _updateAccessTokenBloc.call();
  }

  @override
  void dispose() {
    _loadMessagesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateAccessTokenBloc, BaseState>(
      bloc: _updateAccessTokenBloc,
      listener: (context, state) {
        if (state is SuccessState<AuthCredentialsEntity>) {
          _loadMessagesBloc.add(LoadMessages(widget.chatId));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/${FalaTuImagesEnum.background.value}",
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Bla Bla Bla Bla"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: BlocBuilder<LoadMessagesBloc, BaseState>(
                      bloc: _loadMessagesBloc,
                      builder: (context, state) {
                        if (state is SuccessState<List<MessageEntity>>) {
                          return ListView.separated(
                            itemCount: state.data.length,
                            padding: const EdgeInsets.all(8),
                            separatorBuilder: (context, index) => 8.ph,
                            itemBuilder: (context, index) {
                              final message = state.data[index];
                              final bool isMe =
                                  message.sender.id == _preferences.getUserId();

                              if (message is TextMessageEntity) {
                                return TextMessageCard(
                                    message: message, isMe: isMe);
                              }
                              return Text(message.id);
                            },
                          );
                        }
                        return const CircularProgressIndicator();
                      })),
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            color: Colors.red,
                            margin: const EdgeInsets.all(8.0),
                            child:
                                TextField(controller: _textMessageController))),
                    IconButton(
                        onPressed: () {
                          final userId = _preferences.getUserId();
                          final message = SendMessageEntity(
                              senderId: userId!,
                              type: MessageType.text,
                              text: _textMessageController.text.trim());

                          _sendMessageBloc.call(widget.chatId, message);

                          _textMessageController.clear();
                        },
                        icon: const Icon(Icons.send)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
