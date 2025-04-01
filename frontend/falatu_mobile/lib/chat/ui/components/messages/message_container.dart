import "package:falatu_mobile/commons/utils/extensions/date_extensions.dart";
import "package:flutter/material.dart";

class MessageContainer extends StatelessWidget {
  final Widget content;
  final bool isMe;
  final DateTime createdAt;
  final bool wasSeen;
  final double? maxWidth;
  final double? height;

  const MessageContainer({
    required this.content,
    required this.createdAt,
    required this.wasSeen,
    required this.isMe,
    super.key,
    this.maxWidth,
    this.height,
  });

  static const Radius _radius = Radius.circular(24);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final typography = Theme.of(context).textTheme;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        height: height,
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? MediaQuery.of(context).size.width * 0.7,
        ),
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
                    topRight: _radius,
                    topLeft: _radius,
                    bottomRight: isMe ? Radius.zero : _radius,
                    bottomLeft: isMe ? _radius : Radius.zero,
                  ),
                  color: (isMe
                          ? colors.surfaceContainerLow
                          : colors.secondaryContainer)
                      .withValues(alpha: 0.9),
                ),
                child: content,
              ),
              Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 4, left: 8),
                  child: Text(
                    createdAt.toTime(),
                    style: typography.bodyMedium!.copyWith(
                      color: colors.surfaceBright,
                      fontWeight: FontWeight.w400,
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
