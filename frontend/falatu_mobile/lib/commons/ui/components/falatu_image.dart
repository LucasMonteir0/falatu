import "dart:io";
import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/commons/ui/components/falatu_cached_image.dart";
import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class FalaTuImage extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit fit;
  static const String _path = "assets/images/";
  final Widget image;

  FalaTuImage.network(
      {required String url,
      super.key,
      this.width,
      this.height,
      this.fit = BoxFit.contain})
      : image = FalaTuNetworkImage(
            url: url, fit: fit, width: width, height: height);

  FalaTuImage.asset(
      {required FalaTuImagesEnum image,
      super.key,
      this.width,
      this.height,
      this.fit = BoxFit.contain})
      : image = Image.asset(_path + image.value,
            height: height, width: width, fit: fit);

  FalaTuImage.memory(
      {required Uint8List bytes,
      super.key,
      this.width,
      this.height,
      this.fit = BoxFit.contain})
      : image = Image.memory(bytes, height: height, width: width, fit: fit);

  FalaTuImage.xFile({
    required XFile file,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  }) : image = kIsWeb
            ? Image.network(file.path, height: height, width: width, fit: fit)
            : Image.file(File(file.path),
                height: height, width: width, fit: fit);

  @override
  Widget build(BuildContext context) {
    return image;
  }
}
