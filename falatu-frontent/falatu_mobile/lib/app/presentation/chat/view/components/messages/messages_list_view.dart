import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/commons/config/strings.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/presentation/chat/blocs/messages/get_chat_messages_bloc.dart';
import 'package:falatu/app/presentation/chat/blocs/messages/messages_event.dart';
import 'package:falatu/app/presentation/chat/view/components/messages/cards/image_message_card.dart';
import 'package:falatu/app/presentation/chat/view/components/messages/cards/text_message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MessagesListView extends StatefulWidget {
  const MessagesListView(
      {super.key, required this.chatId, required this.userId});

  final String chatId;
  final String userId;

  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView> {
  late GetChatMessagesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<GetChatMessagesBloc>();
    _bloc.add(LoadMessages(widget.chatId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetChatMessagesBloc, BaseState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is SuccessState<List<MessageEntity>>) {
            return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final message = state.data[index];
                  final bool isMe = message.senderId == widget.userId;
                  switch (message.type) {
                    case Strings.textType:
                      return TextMessageCard(message: message, isMe: isMe);
                    case Strings.imageType:
                      return ImageMessageCard(message: message, isMe: isMe);
                    case Strings.videoType:
                      return TextMessageCard(message: message, isMe: isMe);
                    case Strings.documentType:
                      return TextMessageCard(message: message, isMe: isMe);
                    default:
                      return const SizedBox.shrink();
                  }
                });
          }
          return const SizedBox.square(
              dimension: 32, child: CircularProgressIndicator.adaptive());
        });
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
