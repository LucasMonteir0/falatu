import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:flutter/material.dart";

class FalaTuLogo extends StatelessWidget {
  final double? width;
  final double? height;

  const FalaTuLogo({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/${FalaTuImagesEnum.falatuLogo.value}",
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
