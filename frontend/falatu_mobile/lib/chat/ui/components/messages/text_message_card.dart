import "package:falatu_mobile/chat/core/domain/entities/message/text_message_entity.dart";
import "package:falatu_mobile/chat/ui/components/messages/message_container.dart";
import "package:flutter/material.dart";

class TextMessageCard extends StatelessWidget {
  final TextMessageEntity message;
  final bool isMe;

  const TextMessageCard({required this.message, required this.isMe, super.key});

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: MessageContainer(
        createdAt: message.createdAt,
        wasSeen: false,
        isMe: isMe,
        content: Text(
          message.text,
          style: typography.bodyMedium!.copyWith(
            color: isMe ? colors.surfaceBright : colors.onSurface,
          ),
        ),
      ),
    );
  }
}
