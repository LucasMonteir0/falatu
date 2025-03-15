import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/ui/components/falatu_user_avatar.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/date_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/message_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class ChatTile extends StatelessWidget {
  final String title;
  final String? pictureUrl;
  final MessageEntity? lastMessage;
  final VoidCallback onTap;
  final int unreadsCount;
  final String tag;

  const ChatTile({
    required this.title,
    required this.pictureUrl,
    required this.onTap,
    required this.tag,
    required this.unreadsCount,
    super.key,
    this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: colors.secondaryContainer.withValues(alpha: 0.1),
        onTap: onTap,
        child: Ink(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.all(16),
          child: Hero(
            tag: tag,
            child: Row(
              children: [
                FalaTuUserAvatar(size: 50, pictureUrl: pictureUrl),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    style: typography.bodyLarge!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                if (lastMessage != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      lastMessage!.createdAt
                                          .formatForChat(context),
                                      style: typography.bodyMedium!.copyWith(
                                          color: unreadsCount > 0
                                              ? colors.primary
                                              : colors.onSurface,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                              ],
                            ),
                            if (lastMessage == null)
                              const Expanded(child: SizedBox(height: 25))
                            else
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Builder(builder: (context) {
                                      final userId = Modular.get<
                                              SharedPreferencesService>()
                                          .getUserId();
                                      final isMe =
                                          userId == lastMessage!.sender.id;
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${isMe ? "${context.i18n.you}: " : ""}${lastMessage!.getLastMessageText(context)}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: typography.bodyMedium,
                                            ),
                                          ),
                                          if (unreadsCount > 0)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: _Counter(unreadsCount),
                                            ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
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

class _Counter extends StatelessWidget {
  final int num;

  const _Counter(this.num);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(22)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 20,
          minHeight: 20,
          minWidth: 20,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              num > 999 ? "+999" : num.toString(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surfaceBright,
                    fontSize: 10,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
