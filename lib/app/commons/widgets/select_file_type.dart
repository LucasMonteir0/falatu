import 'package:flutter/material.dart';

class SelectFileType extends StatelessWidget {
  const SelectFileType(
      {Key? key,
      required this.onTapImages,
      required this.onTapVideos,
      required this.onTapFiles})
      : super(key: key);

  final void Function() onTapImages;
  final void Function() onTapVideos;
  final void Function() onTapFiles;

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {},
                child: const Text('Câmera'),
              ),
              const SizedBox(height: padding),
              InkWell(
                onTap: onTapImages,
                child: const Text('Fotos'),
              ),
              const SizedBox(height: padding),
              InkWell(
                onTap: onTapVideos,
                child: const Text('Videos'),
              ),
              const SizedBox(height: padding),
              InkWell(
                onTap: onTapFiles,
                child: const Text('Arquivos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
