import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/ui/components/falatu_splash_effect.dart";
import "package:falatu_mobile/commons/ui/components/falatu_user_avatar.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:flutter/material.dart";

class NonFriendsTile extends StatelessWidget {
  final UserEntity user;
  final VoidCallback? onTap;
  final bool isButtonLoading;

  const NonFriendsTile({
    required this.user,
     this.onTap,
    super.key,
    this.isButtonLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Ink(
      width: double.infinity,
      height: 95,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          FalaTuUserAvatar(size: 60, pictureUrl: user.pictureUrl),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: typography.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    FalaTuSplashEffect(
                      backgroundColor: colors.primary,
                      borderRadius: BorderRadius.circular(16),
                      onTap: onTap,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      child: isButtonLoading
                          ? SizedBox.square(
                              dimension: 16,
                              child: CircularProgressIndicator(
                                  color: colors.surfaceBright, strokeWidth: 2))
                          : Text(
                              context.i18n.startConversation,
                              style: typography.bodyMedium!.copyWith(
                                color: colors.surfaceBright,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
