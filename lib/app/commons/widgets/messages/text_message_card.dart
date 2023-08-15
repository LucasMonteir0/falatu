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
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(
          maxWidth: size.width * 0.6,
        ),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: isMe
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16),
                )
              : const BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            isMe ? Text(message.message) : Text('${message.message}    '),
            Text(time),
          ],
        ),
      ),
    );
  }
}
