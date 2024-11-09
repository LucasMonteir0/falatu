import 'package:falatu/app/presentation/chat/view/components/messages/messages_list_view.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/user/user_entity.dart';
import 'package:falatu/app/presentation/chat/view/components/messages/send_message_component.dart';
import 'package:flutter/material.dart';

class PrivateChatPageParams {
  final ChatEntity chat;
  final UserEntity user;

  PrivateChatPageParams({required this.chat, required this.user});
}

class PrivateChatPage extends StatelessWidget {
  const PrivateChatPage({Key? key, required this.params}) : super(key: key);

  final PrivateChatPageParams params;

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
                child: MessagesListView(
              chatId: params.chat.id,
              userId: params.user.id,
            )),
            SendMessageComponent(
              chat: params.chat,
              userId: params.user.id,
            ),
          ],
        ),
      ),
    );
  }
}
