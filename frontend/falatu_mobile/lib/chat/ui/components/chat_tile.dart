import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/utils/strings/tags.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
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

  const ChatTile({
    required this.title,
    required this.pictureUrl,
    required this.onTap,
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
          height: 95,
          padding: const EdgeInsets.all(16),
          child: Hero(
            tag: Tags.chatTileToHeader,
            child: Row(
              children: [
                FalaTuUserAvatar(size: 60, pictureUrl: pictureUrl),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IntrinsicWidth(
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
                                    style: typography.bodyMedium,
                                  ),
                                ),
                            ],
                          ),
                          if (lastMessage != null)
                            Expanded(
                              child: Builder(builder: (context) {
                                final userId =
                                    Modular.get<SharedPreferencesService>()
                                        .getUserId();
                                final isMe = userId == lastMessage!.sender.id;
                                return Text(
                                  "${isMe ? "${context.i18n.you}: " : ""}${lastMessage!.getLastMessageText(context)}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: typography.bodyMedium,
                                );
                              }),
                            )
                        ],
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
