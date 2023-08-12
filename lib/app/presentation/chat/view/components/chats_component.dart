import 'package:falatu/app/commons/widgets/chat_card.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:flutter/material.dart';

class ChatsComponent extends StatelessWidget {
  const ChatsComponent({Key? key, required this.chats}) : super(key: key);

  final List<ChatEntity> chats;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chats.length,
        // shrinkWrap: ,
        itemBuilder: (context, index) {
          return ChatCard();
        });
  }
}
