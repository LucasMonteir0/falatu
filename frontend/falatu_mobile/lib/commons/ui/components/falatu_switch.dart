import "package:animated_toggle_switch/animated_toggle_switch.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:flutter/material.dart";

class SwitchItem<T> {
  final T value;
  final FalaTuIconsEnum icon;

  SwitchItem(this.value, this.icon);
}

class FalaTuSwitch<T> extends StatelessWidget {
  final T initialValue;
  final List<SwitchItem<T>> items;
  final ValueChanged<T>? onChanged;

  const FalaTuSwitch(
      {required this.initialValue,
      required this.items,
      super.key,
      this.onChanged});

  FalaTuIconsEnum _handleIcons(T value) {
    final item = items.firstWhere((e) => e.value == value);
    return item.icon;
  }

  final double _size = 30.0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AnimatedToggleSwitch<T>.rolling(
      height: _size,
      current: initialValue,
      values: items.map((e) => e.value).toList(),
      indicatorSize: Size.square(_size - 4),
      onChanged: onChanged,
      iconBuilder: (value, foreground) => FalaTuIcon(
        icon: _handleIcons(value),
        size: _size - 10,
        color: value == initialValue ? colors.surfaceBright : colors.onSurface,
      ),
      style: ToggleStyle(
        borderColor: Colors.transparent,
        indicatorColor: colors.primaryContainer,
        backgroundColor: colors.surfaceContainer,
        boxShadow: [

        ],
      ),
    );
  }
}
