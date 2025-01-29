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

  const FalaTuIcon({
    required this.icon,
    this.size = 26,
    this.onTap,
    this.color,
    super.key,
    this.padding,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:  padding != null ? BorderRadius.circular(4) : BorderRadius.zero,
      splashFactory: InkSplash.splashFactory,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: SizedBox.square(
          dimension: size,
          child: SvgPicture.asset(
            '$_iconsAssetsPath${icon.value}',
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
