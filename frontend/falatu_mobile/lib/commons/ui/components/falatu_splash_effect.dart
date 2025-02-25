import "package:flutter/material.dart";

class FalaTuSplashEffect extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? size;

  const FalaTuSplashEffect(
      {super.key,
      this.backgroundColor,
      required this.child,
      this.borderRadius,
      this.padding,
      this.onTap,
      this.size});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
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
