import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:flutter/material.dart";

class FalaTuTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode? autovalidateMode;
  final String? label;
  final bool readOnly;
  final bool obscureText;
  final FalaTuIconsEnum? suffixIcon;

  const FalaTuTextInput(
      {super.key,
      this.controller,
      this.initialValue,
      this.onChanged,
      this.autovalidateMode,
      this.readOnly = false,
      this.obscureText = false,
      this.label,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      decoration: _decoration(context),
      readOnly: readOnly,
      obscureText: obscureText,
    );
  }

  InputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: color),
      );

  InputDecoration _decoration(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InputDecoration(
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedBorder: _border(colors.primary),
      errorBorder: _border(colors.error),
      border: _border(colors.outline),
      suffixIcon: suffixIcon.let(
        (icon) => FalaTuIcon(icon: icon, color: colors.outline),
      ),
    );
  }
}
