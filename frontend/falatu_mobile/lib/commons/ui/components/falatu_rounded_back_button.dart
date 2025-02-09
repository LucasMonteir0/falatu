import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class FalaTuRoundedBackButton extends StatelessWidget {
  final void Function()? onTap;
  const FalaTuRoundedBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      type: MaterialType.button,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: onTap ?? () => Modular.to.pop(),
        splashColor: colors.primary,
        child: Ink(
          width: 36,
          height: 36,
          color: colors.primary.withAlpha(70),
          child: Center(
            child: FalaTuIcon(
              icon: FalaTuIconsEnum.chevronLeft,
              size: 32,
              color: colors.onInverseSurface,
            ),
          ),
        ),
      ),
    );
  }
}
