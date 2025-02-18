import "dart:ui";

import "package:flutter/material.dart";

class BlurEffect extends StatelessWidget {
  final Color? color;
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;

  const BlurEffect({
    required this.child,
    super.key,
    this.color,
    this.borderRadius,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: color ?? colors.surface.withValues(alpha: 0.7),
              borderRadius: borderRadius),
          child: child,
        ),
      ),
    );
  }
}
