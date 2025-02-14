import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class FalaTuIcon extends StatelessWidget {
  static const String _iconsAssetsPath = "assets/icons/";
  final FalaTuIconsEnum icon;
  final Color? color;
  final double size;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final BoxFit fit;
  final bool? enableFeedback;

  const FalaTuIcon({
    required this.icon,
    this.size = 26,
    this.onTap,
    this.color,
    super.key,
    this.padding,
    this.fit = BoxFit.contain, this.enableFeedback,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onTap,
        enableFeedback: enableFeedback,
        splashFactory: InkSplash.splashFactory,
        child: Ink(
          padding: padding ?? EdgeInsets.zero,
         height: size,
          width: size,
          child: SvgPicture.asset(
            "$_iconsAssetsPath${icon.value}",
            colorFilter: color != null
                ? ColorFilter.mode(
                    color!,
                    BlendMode.srcIn,
                  )
                : null,
            fit: fit,
          ),
        ),
      ),
    );
  }
}
