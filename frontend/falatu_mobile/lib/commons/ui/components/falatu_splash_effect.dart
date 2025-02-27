import "package:flutter/material.dart";

class FalaTuSplashEffect extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double elevation;
  final Color? shadowColor;
  final double? size;

  const FalaTuSplashEffect(
      {required this.child, super.key,
      this.backgroundColor,
      this.borderRadius,
      this.padding,
      this.onTap,
      this.elevation = 0.0,
      this.size, this.shadowColor});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      elevation: elevation,
      shadowColor: shadowColor,
      child: InkWell(
        splashColor: colors.secondaryContainer.withValues(alpha: 0.15),
        highlightColor: colors.secondaryContainer.withValues(alpha: 0.06),

        onTap: onTap,
        child: Ink(
          width: size,
          height: size,
          padding: padding ?? const EdgeInsets.all(8),
          color: backgroundColor,
          child: child,
        ),
      ),
    );
  }
}
