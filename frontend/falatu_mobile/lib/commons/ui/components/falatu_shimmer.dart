import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

class FalaTuShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? _size;
  final bool isCircle;
  final BorderRadiusGeometry? _customBorder;

  const FalaTuShimmer.rectangle({this.width, this.height, super.key})
      : _size = null,
        isCircle = false,
        _customBorder = null;

  const FalaTuShimmer.circle({double? size, super.key})
      : width = size,
        height = size,
        _size = size,
        _customBorder = null,
        isCircle = true;

  const FalaTuShimmer.customBorder(
      {required BorderRadiusGeometry border,
        this.width,
        this.height,
        super.key})
      : _size = null,
        _customBorder = border,
        isCircle = false;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: color.surfaceContainerHighest.withValues(alpha: 0.7),
      highlightColor: color.surfaceContainer.withValues(alpha: 0.7),
      child: SizedBox(
        height: _size ?? height ?? double.infinity,
        width: _size ?? width ?? double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: color.onPrimaryContainer.withValues(alpha: 0.5),
            borderRadius: _customBorder ??
                (isCircle
                    ? BorderRadius.circular(_size! / 2)
                    : BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}
