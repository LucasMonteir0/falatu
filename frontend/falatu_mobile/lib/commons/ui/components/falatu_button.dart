import "package:flutter/material.dart";

enum ButtonType { filled, outlined, text, link }

class FalaTuButton extends StatelessWidget {
  final String label;
  final ButtonType type;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final bool isLoading;

  const FalaTuButton(
      {required this.label,
      this.isLoading = false,
      super.key,
      this.type = ButtonType.filled,
      this.onTap,
      this.padding});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    switch (type) {
      case ButtonType.filled:
        return FilledButton(
          onPressed: isLoading ? null : onTap,
          style: FilledButton.styleFrom(padding: padding),
          child: isLoading
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2))
              : _Text(label, color: Colors.white),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onTap,
          style: OutlinedButton.styleFrom(
              padding: padding,
              side: BorderSide(color: colors.primary, width: 2)),
          child: isLoading
              ? SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(
                      color: colors.primary, strokeWidth: 2))
              : _Text(label, color: colors.primary),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 8)),
          child: _Text(label, color: colors.primary),
        );
      case ButtonType.link:
        return TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
              padding: padding, visualDensity: VisualDensity.compact),
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
