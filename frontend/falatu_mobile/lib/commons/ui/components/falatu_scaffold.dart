import "dart:io";

import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:flutter/material.dart";

class ScaffoldAction {
  final FalaTuIconsEnum icon;
  final VoidCallback? onTap;

  ScaffoldAction({required this.icon, this.onTap});
}

class FalaTuScaffold extends StatelessWidget {
  final Widget? body;
  final String? title;
  final bool hasSafeArea;
  final Color? backgroundColor;
  final List<ScaffoldAction>? actions;

  const FalaTuScaffold(
      {super.key,
      this.body,
      this.hasSafeArea = false,
      this.title,
      this.backgroundColor,
      this.actions});

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        if (Platform.isIOS) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor ?? colors.surface,
        appBar: title != null
            ? AppBar(
                centerTitle: false,
                backgroundColor: Colors.transparent,
                actions: actions.let((list) => list
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FalaTuIcon(
                            icon: e.icon,
                            onTap: e.onTap,
                            enableFeedback: true,
                          ),
                        ))
                    .toList()),
                title: Text(
                  title!,
                  style: typography.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : null,
        body: hasSafeArea ? SafeArea(child: SizedBox(child: body)) : body,
      ),
    );
  }
}
