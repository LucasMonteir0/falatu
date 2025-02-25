import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

class FalaTuNetworkImage extends StatelessWidget {
  final String url;
  final Widget? placeholder;
  final BoxFit fit;
  final double? width;
  final double? height;

  const FalaTuNetworkImage(
      {required this.url,
      super.key,
      this.placeholder,
      this.fit = BoxFit.contain, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (_, __) => placeholder ?? const SizedBox.shrink(),
      errorWidget: (_, __, error) => const Icon(Icons.error),
      fit: fit,
      width: width,
      height: height,
    );
  }
}
