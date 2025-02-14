import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

class FalaTuCachedNetworkImage extends StatelessWidget {
  final String url;
  final Widget? placeholder;
  final BoxFit fit;

  const FalaTuCachedNetworkImage(
      {required this.url,
      super.key,
      this.placeholder,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (_, __) => placeholder ?? const SizedBox.shrink(),
      errorWidget: (_, __, error) => const Icon(Icons.error),
      fit: fit,
    );
  }
}
