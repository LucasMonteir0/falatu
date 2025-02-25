import "package:falatu_mobile/commons/ui/components/falatu_cached_image.dart";
import "package:falatu_mobile/commons/ui/components/falatu_shimmer.dart";
import "package:flutter/material.dart";

class FalaTuUserAvatar extends StatelessWidget {
  final double size;
  final String? pictureUrl;

  const FalaTuUserAvatar({required this.size, super.key, this.pictureUrl});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surface,
        shape: BoxShape.circle,
      ),
      child: pictureUrl != null
          ? FalaTuNetworkImage(
              url: pictureUrl!,
              placeholder: FalaTuShimmer.circle(size: size),
              fit: BoxFit.cover,
            )
          : Center(
              child: Icon(
                Icons.person_rounded,
                size: size * 0.7,
                color: colors.onSurface,
              ),
            ),
    );
  }
}
