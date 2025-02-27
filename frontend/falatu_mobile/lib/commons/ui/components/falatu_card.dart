import "package:flutter/material.dart";

class FalaTuCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;

  const FalaTuCard({super.key, this.child, this.padding, this.margin, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: padding ?? const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
