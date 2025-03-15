import "package:falatu_mobile/chat/core/domain/entities/chat/private_chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/file_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_text_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/text_message_entity.dart";
import "package:falatu_mobile/chat/ui/blocs/add_old_messages/add_old_messages.dart";
import "package:falatu_mobile/chat/ui/blocs/load_messages/load_messages_bloc.dart";
import "package:falatu_mobile/chat/ui/blocs/load_messages/message_events.dart";
import "package:falatu_mobile/chat/ui/blocs/send_message/send_messge_bloc.dart";
import "package:falatu_mobile/chat/ui/components/chat_app_bar_content.dart";
import "package:falatu_mobile/chat/ui/components/media/pick_files_bottom_sheet.dart";
import "package:falatu_mobile/chat/ui/components/message_input.dart";
import "package:falatu_mobile/chat/ui/components/messages/file_message_card.dart";
import "package:falatu_mobile/chat/ui/components/messages/messages_list_view.dart";
import "package:falatu_mobile/chat/ui/components/messages/text_message_card.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/chat/utils/strings/tags.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/ui/components/falatu_circular_progress_indicator.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_splash_effect.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class PrivateChatPage extends StatefulWidget {
  final PrivateChatEntity chat;

  const PrivateChatPage({required this.chat, super.key});

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  late final TextEditingController _textMessageController =
      TextEditingController();

  late final LoadMessagesBloc _loadMessagesBloc;
  late final AddOldMessagesBloc _addOldMessagesBloc;
  late final SendMessageBloc _sendMessageBloc;
  late final SharedPreferencesService _preferences;
  late final ScrollController _scrollController;

  int page = 1;

  @override
  void initState() {
    super.initState();
    _loadMessagesBloc = Modular.get<LoadMessagesBloc>();
    _sendMessageBloc = Modular.get<SendMessageBloc>();
    _preferences = Modular.get<SharedPreferencesService>();
    _addOldMessagesBloc = Modular.get<AddOldMessagesBloc>();
    _scrollController = ScrollController();
    _loadMessagesBloc.add(LoadMessages(widget.chat.id));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _loadMessagesBloc.close();
    _addOldMessagesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // leadingWidth: 30,
          centerTitle: false,
          forceMaterialTransparency: true,
          title: Hero(
            tag: Tags.chatTile + widget.chat.id,
            child: ChatAppBarContent(
              title: widget.chat.otherUser.name,
              pictureUrl: widget.chat.otherUser.pictureUrl,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: BlocConsumer<LoadMessagesBloc, BaseState>(
                bloc: _loadMessagesBloc,
                listener: (context, state) async {
                  if (state is SuccessState<List<MessageEntity>>) {
                    await Future.delayed(const Duration(milliseconds: 500));
                    if (_scrollController.positions.isEmpty) {
                      _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeOut,
                      );
                    }
                  }
                },
                builder: (context, state) {
                  if (state is SuccessState<List<MessageEntity>>) {
                    return MessagesListView(
                      data: state.data,
                      controller: _scrollController,
                      onMaxExtent: () {
                        page += 1;
                        _addOldMessagesBloc.call(widget.chat.id, page);
                      },
                      builder: (context, message, index) {
                        if (index >= state.data.length) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: FalaTuCircularProgressIndicator(
                                strokeWidth: 4,
                                padding: 6,
                              ),
                            ),
                          );
                        }

                        final bool isMe =
                            message.sender.id == _preferences.getUserId();

                        switch (message.type) {
                          case MessageType.text:
                            return TextMessageCard(
                              message: message as TextMessageEntity,
                              isMe: isMe,
                            );
                          case MessageType.file:
                            return FileMessageCard(
                              message: message as FileMessageEntity,
                              isMe: isMe,
                            );
                          default:
                            return Text(message.id);
                        }
                      },
                    );
                  }
                  if (state is LoadingState) {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FalaTuCircularProgressIndicator(
                          strokeWidth: 4,
                          padding: 6,
                        ),
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MessageInput(
                        controller: _textMessageController,
                        onAddTap: () => PickFilesBottomSheet.show(context,
                            chatId: widget.chat.id),
                      ),
                    ),
                    4.pw,
                    FalaTuSplashEffect(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        if (_textMessageController.text.trim().isEmpty) {
                          return;
                        }
                        final userId = _preferences.getUserId();
                        final message = SendTextMessageEntity(
                            senderId: userId!,
                            text: _textMessageController.text.trim());

                        _sendMessageBloc.call(widget.chat.id, message);

                        _textMessageController.clear();
                      },
                      child: const FalaTuIcon(
                        icon: FalaTuIconsEnum.sendFilled,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
