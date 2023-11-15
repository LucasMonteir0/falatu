import 'package:falatu/app/commons/config/constants.dart';
import 'package:falatu/app/commons/helpers/get_document_extension_icon.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DocumentMessageCard extends StatelessWidget {
  const DocumentMessageCard(
      {super.key, required this.message, required this.isMe});

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
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        constraints: BoxConstraints(
          maxWidth: size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isMe ? Colors.amber : Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(messageCardRadius),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(getDocumentExtensionIcon(message.extension!)),
                Text(message.extension!),
              ],
            ),
            Stack(
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
          ],
        ),
      ),
    );
  }
}
