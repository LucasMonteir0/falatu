import "package:flutter/material.dart";

class FalaTuBottomSheet extends StatelessWidget {
  final Widget child;

  FalaTuBottomSheet.show({
    required BuildContext context,
    required this.child,
    super.key,
  }) {

    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}