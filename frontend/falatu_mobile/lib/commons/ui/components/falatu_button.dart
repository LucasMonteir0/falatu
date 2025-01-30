import "package:flutter/material.dart";

enum ButtonType { filled, outlined, text }

class FalaTuButton extends StatelessWidget {
  final String label;
  final ButtonType type;
  final VoidCallback? onTap;

  const FalaTuButton(
      {required this.label,
      super.key,
      this.type = ButtonType.filled,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    switch (type) {
      case ButtonType.filled:
        return FilledButton(
          onPressed: onTap,
          child: _Text(label, color: Colors.white),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: colors.primary, width: 2)),
          child: _Text(label, color: colors.primary),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onTap,
          child: _Text(label, color: colors.primary, hasUnderline: true),
        );
    }
  }
}

class _Text extends StatelessWidget {
  final String text;
  final Color color;
  final bool hasUnderline;

  const _Text(this.text, {required this.color, this.hasUnderline = false});

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Text(
      text,
      style: typography.bodyMedium!.copyWith(
        color: hasUnderline ? Colors.transparent : color,
        shadows: hasUnderline
            ? <Shadow>[Shadow(color: color, offset: const Offset(0, -3))]
            : null,
        fontWeight: FontWeight.w600,
        decoration: hasUnderline ? TextDecoration.underline : null,
        decorationColor: colors.primary,
        decorationThickness: 2,
      ),
    );
  }
}
