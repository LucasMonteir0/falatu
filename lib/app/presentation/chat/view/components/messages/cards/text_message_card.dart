import 'package:falatu/app/commons/config/constants.dart';
import 'package:falatu/app/presentation/chat/view/components/messages/cards/message_card_tail.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextMessageCard extends StatelessWidget {
  const TextMessageCard({Key? key, required this.message, required this.isMe})
      : super(key: key);

  final MessageEntity message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String time = DateFormat.Hm().format(message.timestamp);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
        child: CustomPaint(
          painter: MessageCardTail(
            color: isMe ? Colors.amber : Colors.lightBlueAccent,
            isOwn: isMe,
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            constraints: BoxConstraints(
              maxWidth: size.width * 0.7,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(messageCardRadius),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    '${message.message}         ',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    time,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
