import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/commons/widgets/messages/text_message_card.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/core/domains/entities/user/user_entity.dart';
import 'package:falatu/app/presentation/chat/blocs/messages/get_chat_messages_bloc.dart';
import 'package:falatu/app/presentation/chat/blocs/messages/messages_event.dart';
import 'package:falatu/app/presentation/chat/view/components/send_message_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PrivateChatPageParams {
  final ChatEntity chat;
  final UserEntity user;

  PrivateChatPageParams({required this.chat, required this.user});
}

class PrivateChatPage extends StatefulWidget {
  const PrivateChatPage({Key? key, required this.params}) : super(key: key);

  final PrivateChatPageParams params;

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  late GetChatMessagesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<GetChatMessagesBloc>();
    _bloc.add(LoadMessages(widget.params.chat.id));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<GetChatMessagesBloc, BaseState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is SuccessState<List<MessageEntity>>) {
                      return ListView.builder(
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            final message = state.data[index];
                            final bool isMe =
                                message.senderId == widget.params.user.id;
                            return TextMessageCard(
                                message: message, isMe: isMe);
                          });
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
            SendMessageComponent(
              chat: widget.params.chat,
              userId: widget.params.user.id,
            ),
          ],
        ),
      ),
    );
  }
}
