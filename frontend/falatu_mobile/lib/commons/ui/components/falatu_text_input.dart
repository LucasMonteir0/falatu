import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class FalaTuTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode? autovalidateMode;
  final String? label;
  final bool readOnly;
  final bool obscureText;
  final FalaTuIconsEnum? prefixIcon;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;

  const FalaTuTextInput({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.autovalidateMode,
    this.readOnly = false,
    this.obscureText = false,
    this.label,
    this.prefixIcon,
    this.focusNode,
    this.enabled = true,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.hint,
  });

  @override
  State<FalaTuTextInput> createState() => _FalaTuTextInputState();
}

class _FalaTuTextInputState extends State<FalaTuTextInput> {
  static const double iconSize = 28.0;
  late final FocusNode _focusNode = widget.focusNode ?? FocusNode();
  late bool showText = widget.obscureText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.removeListener(() {});
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      style: typography.bodyMedium!.copyWith(color: colors.primary),
      autovalidateMode: widget.autovalidateMode,
      decoration: _decoration(context, widget.hint),
      readOnly: widget.readOnly,
      obscureText: showText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
    );
  }

  InputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color),
      );

  Color _handleFillColor(ColorScheme colors) {
    return !widget.enabled || _focusNode.hasFocus
        ? colors.surfaceContainer
        : colors.surfaceContainerLow;
  }

  InputDecoration _decoration(BuildContext context, String? hint) {
    final colors = Theme.of(context).colorScheme;
    final typography = Theme.of(context).textTheme;
    return InputDecoration(
      contentPadding: const EdgeInsets.all(16),
      isDense: true,
      filled: true,
      alignLabelWithHint: false,
      helperText: hint,
      helperMaxLines: 3,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabled: widget.enabled,
      fillColor: _handleFillColor(colors),
      focusedBorder: _border(colors.surfaceContainerLow),
      errorBorder: _border(colors.error),
      border: _border(colors.surfaceContainerLow),
      enabledBorder: _border(colors.surfaceContainerLow),
      disabledBorder: _border(colors.surfaceContainerLow),
      prefix: widget.prefixIcon.let((_) => 8.pw),
      suffix: widget.obscureText ? 8.pw : null,
      prefixIconConstraints:
          const BoxConstraints(maxWidth: iconSize, maxHeight: iconSize),
      suffixIconConstraints: const BoxConstraints(maxWidth: 40, maxHeight: 40),
      prefixIcon: widget.prefixIcon.let(
        (icon) => Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FalaTuIcon(
                icon: icon,
                color: widget.enabled
                    ? colors.primary
                    : colors.surfaceContainerHighest,
                size: iconSize)),
      ),
      suffixIcon: widget.obscureText
          ? Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: FalaTuIcon(
                icon: showText
                    ? FalaTuIconsEnum.visibilityOnFilled
                    : FalaTuIconsEnum.visibilityOffFilled,
                color: colors.primary,
                size: 36,
                onTap: () => setState(() => showText = !showText),
              ),
            )
          : null,
      label: widget.label.let(
        (label) => Padding(
            padding: widget.prefixIcon != null
                ? const EdgeInsets.only(left: 8.0)
                : EdgeInsets.zero,
            child: Text(label,
                style: typography.bodyMedium!.copyWith(
                    color: colors.primary, fontWeight: FontWeight.w600))),
      ),
    );
  }
}
