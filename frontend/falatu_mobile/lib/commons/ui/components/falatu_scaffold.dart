import "dart:io";

import "package:flutter/material.dart";

class FalaTuScaffold extends StatelessWidget {
  final Widget? body;
  final bool hasSafeArea;

  const FalaTuScaffold({super.key, this.body, this.hasSafeArea = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        if (Platform.isIOS) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: colors.surface,
        body: hasSafeArea ? SafeArea(child: SizedBox(child: body)) : body,
      ),
    );
  }
}
