import "package:falatu_mobile/chat/core/domain/entities/message/image_message_entity.dart";
import "package:falatu_mobile/chat/ui/components/messages/message_container.dart";
import "package:falatu_mobile/commons/ui/components/falatu_cached_image.dart";
import "package:flutter/material.dart";

class ImageMessageCard extends StatelessWidget {
  final ImageMessageEntity message;
  final bool isMe;

  const ImageMessageCard(
      {required this.message, required this.isMe, super.key});

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
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 250),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: FalaTuNetworkImage(
                    url: message.mediaUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (message.text != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Text(
                  message.text!,
                  style: typography.bodyMedium!.copyWith(
                    color: isMe ? colors.onSurface : colors.surfaceBright,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
