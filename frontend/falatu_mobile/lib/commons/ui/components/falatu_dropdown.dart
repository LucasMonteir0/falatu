import "package:animated_custom_dropdown/custom_dropdown.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:flutter/material.dart";

class FalaTuDropdownItem<T> {
  final T value;
  final String text;

  @override
  String toString() {
    return text;
  }

  FalaTuDropdownItem({required this.value, required this.text});
}

class FalatuDropdown<T> extends StatefulWidget {
  final T? value;
  final List<FalaTuDropdownItem<T>> items;
  final ValueChanged<T>? onChanged;

  const FalatuDropdown(
      {required this.items, super.key, this.value, this.onChanged});

  @override
  State<FalatuDropdown<T>> createState() => _FalatuDropdownState<T>();
}

class _FalatuDropdownState<T> extends State<FalatuDropdown<T>> {
  late final _controller = OverlayPortalController();

  String? _handleInitialValue() {
    return widget.value
        .let((e) => widget.items.firstWhere((i) => i.value == e))
        ?.text;
  }

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return CustomDropdown<String>(
      items: widget.items.map((e) => e.text).toList(),
      initialItem: _handleInitialValue(),
      onChanged: (item) async {
        await Future.delayed(const Duration(milliseconds: 450));
        if (item != null && !_controller.isShowing) {
          final result = widget.items.firstWhere((e) => e.text == item);
          widget.onChanged?.call(result.value);
        }
      },
      closedHeaderPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: CustomDropdownDecoration(
        headerStyle: typography.bodyMedium,
        listItemStyle: typography.bodyMedium,
        closedFillColor: colors.surfaceContainer,
        expandedFillColor: colors.surfaceContainer,
        listItemDecoration: ListItemDecoration(
          highlightColor: colors.secondaryContainer.withValues(alpha: 0.06),
          splashColor: colors.secondaryContainer.withValues(alpha: 0.15),
          selectedColor: colors.surfaceContainer,
        ),
      ),
    );
  }
}
