import "dart:io";

import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_splash_effect.dart";
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
  final Widget? bottomNavigationBar;
  final String? title;
  final Color? titleColor;
  final Color? iconsColor;
  final bool hasSafeArea;
  final bool extendBodyBehindAppBar;
  final Color? backgroundColor;
  final List<ScaffoldAction>? actions;
  final ScaffoldAction? floatingButton;

  const FalaTuScaffold({
    super.key,
    this.body,
    this.hasSafeArea = false,
    this.title,
    this.backgroundColor,
    this.actions,
    this.floatingButton,
    this.titleColor,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
    this.iconsColor,
  });

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
        bottomNavigationBar: bottomNavigationBar,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        floatingActionButton: floatingButton.let(
          (e) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: FalaTuSplashEffect(
                backgroundColor: colors.primary,
                elevation: 2,
                shadowColor: colors.primary,
                borderRadius: BorderRadius.circular(100),
                onTap: e.onTap,
                padding: const EdgeInsets.all(12),
                child: FalaTuIcon(icon: e.icon, size: 24),
              ),
            ),
          ),
        ),
        appBar: title != null
            ? AppBar(
                centerTitle: false,
                backgroundColor: Colors.transparent,
                forceMaterialTransparency: true,
                iconTheme: IconThemeData(color: iconsColor ?? colors.onSurface, size: 20),
                leadingWidth: 20,
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
                    color: titleColor ?? colors.onSurface,
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
