import 'package:falatu/app/commons/config/strings.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/presentation/chat/blocs/messages/send_chat_message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SendMessageComponent extends StatefulWidget {
  const SendMessageComponent(
      {Key? key, required this.chat, required this.userId})
      : super(key: key);

  final ChatEntity chat;
  final String userId;

  @override
  State<SendMessageComponent> createState() => _SendMessageComponentState();
}

class _SendMessageComponentState extends State<SendMessageComponent> {
  late SendChatMessageBloc _sendChatMessageBloc;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _sendChatMessageBloc = Modular.get<SendChatMessageBloc>();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: SafeArea(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextField(
                  controller: _controller,
                  maxLines: 5,
                  minLines: 1,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    border: InputBorder.none,
                    isCollapsed: true,
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () async {
                final MessageEntity newMessage = MessageEntity(
                  message: _controller.text.trim(),
                  senderId: widget.userId,
                  timestamp: DateTime.now(),
                  type: Strings.textType,
                  viewed: List.generate(1, (index) => widget.userId),
                );
                await _sendChatMessageBloc(
                    chat: widget.chat, message: newMessage);
              },
              icon: const Icon(Icons.send_rounded))
        ],
      ),
    );
  }
}
