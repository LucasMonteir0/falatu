import "package:falatu_mobile/chat/ui/components/media/falatu_video_player.dart";
import "package:falatu_mobile/commons/ui/components/falatu_cached_image.dart";
import "package:falatu_mobile/commons/utils/enums/media_type_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/date_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/string_extensions.dart";
import "package:flutter/material.dart";

class MediaDisplayParams {
  final String url;
  final String tag;
  final MediaTypeEnum type;
  final String senderName;
  final DateTime sentAt;

  MediaDisplayParams({
    required this.tag,
    required this.url,
    required this.type,
    required this.senderName,
    required this.sentAt,
  });
}

class MediaDisplayPage extends StatelessWidget {
  final MediaDisplayParams params;

  const MediaDisplayPage({required this.params, super.key});

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surfaceContainerLow,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              params.senderName.toFirstAndLastName(),
              maxLines: 1,
              style: typography.bodyLarge,
            ),
            Text(
              params.sentAt.toDateAndTime(),
              style: typography.labelSmall,
            ),
          ],
        ),
        iconTheme: IconThemeData(color: colors.onSurface),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            switch (params.type) {
              case MediaTypeEnum.image:
                return SingleChildScrollView(
                    child: _ImageDisplay(tag: params.tag, url: params.url));
              case MediaTypeEnum.video:
                return FalaTuVideoPlayer.network(url: params.url);
            }
          },
        ),
      ),
    );
  }
}

class _ImageDisplay extends StatelessWidget {
  final String tag;
  final String url;

  const _ImageDisplay({required this.tag, required this.url});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: FalaTuNetworkImage(url: url),
      ),
    );
  }
}
