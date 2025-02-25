import "package:falatu_mobile/commons/utils/extensions/date_extensions.dart";
import "package:flutter/material.dart";

class MessageContainer extends StatelessWidget {
  final Widget content;
  final bool isMe;
  final DateTime createdAt;
  final bool wasSeen;

  const MessageContainer({
    required this.content,
    required this.createdAt,
    required this.wasSeen,
    required this.isMe,
    super.key,
  });

  static const Radius _radius = Radius.circular(24);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final typography = Theme.of(context).textTheme;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(minWidth: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: _radius,
                    bottomLeft: _radius,
                    topRight: isMe ? Radius.zero : _radius,
                    topLeft: isMe ? _radius : Radius.zero,
                  ),
                  color: (isMe ? colors.surfaceContainerLow : colors.secondaryContainer)
                      .withValues(alpha: 0.9),
                ),
                child: content,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 4),
                  child: Text(
                    createdAt.toTime(),
                    style: typography.bodyMedium!.copyWith(
                      color: colors.surfaceBright,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
