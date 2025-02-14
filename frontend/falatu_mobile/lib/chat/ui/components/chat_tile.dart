import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/commons/ui/components/falatu_cached_network_image.dart";
import "package:falatu_mobile/commons/ui/components/falatu_shimmer.dart";
import "package:falatu_mobile/commons/utils/extensions/date_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/message_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:flutter/material.dart";

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
        onTap: onTap,
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: colors.surface,
                  shape: BoxShape.circle,
                ),
                child: pictureUrl != null
                    ? FalaTuCachedNetworkImage(
                        url: pictureUrl!,
                        placeholder: const FalaTuShimmer.circle(size: 50),
                        fit: BoxFit.cover,
                      )
                    : const Center(
                        child: Icon(Icons.person_rounded),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: typography.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: lastMessage != null ? 4 : 16),
                        if (lastMessage != null)
                          Row(
                            children: [
                              Text(
                                lastMessage!.getLastMessageText(context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: typography.bodySmall,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    DateTime.now().formatForChat(context),
                                    style: typography.bodySmall,
                                  ),
                                ),
                              ),
                            ],
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
    );
  }
}
