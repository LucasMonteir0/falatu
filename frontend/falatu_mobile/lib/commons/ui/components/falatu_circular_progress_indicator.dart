import "package:flutter/material.dart";

class FalaTuCircularProgressIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final double? padding;

  const FalaTuCircularProgressIndicator({
    super.key,
    this.size = 30,
    this.strokeWidth = 2,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding ?? 8),
      decoration: BoxDecoration(
          color: colors.surface,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 4,
            )
          ]),
      child: FittedBox(
        child: CircularProgressIndicator(
          color: colors.primary,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
