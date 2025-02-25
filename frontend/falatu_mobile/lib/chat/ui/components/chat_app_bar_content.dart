import "package:falatu_mobile/commons/ui/components/falatu_user_avatar.dart";
import "package:flutter/material.dart";

class ChatAppBarContent extends StatelessWidget {
  final String title;
  final String? pictureUrl;

  const ChatAppBarContent({
    required this.title,
    required this.pictureUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        FalaTuUserAvatar(size: 45, pictureUrl: pictureUrl),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              style: typography.titleMedium!.copyWith(
                color: colors.surfaceBright,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ],
    );
  }
}
