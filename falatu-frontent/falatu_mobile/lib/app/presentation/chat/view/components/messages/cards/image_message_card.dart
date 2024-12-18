import 'package:cached_network_image/cached_network_image.dart';
import 'package:falatu/app/commons/config/constants.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/presentation/chat/view/components/messages/cards/message_card_tail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';

class ImageMessageCard extends StatefulWidget {
  const ImageMessageCard({Key? key, required this.message, required this.isMe})
      : super(key: key);

  final MessageEntity message;
  final bool isMe;

  @override
  State<ImageMessageCard> createState() => _ImageMessageCardState();
}

class _ImageMessageCardState extends State<ImageMessageCard> {
  final CacheManager _imageCacheManager = CacheManager(
    Config(
      'images_key',
      stalePeriod: const Duration(days: 7),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String time = DateFormat.Hm().format(widget.message.timestamp);
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding:  const EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
        child: CustomPaint(
          painter: MessageCardTail(
            color: widget.isMe ? Colors.amber : Colors.lightBlueAccent,
            isOwn: widget.isMe,
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            constraints: BoxConstraints(
              maxWidth: size.width * 0.6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(messageCardRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(messageCardRadius),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                    ),
                    child: CachedNetworkImage(
                      cacheManager: _imageCacheManager,
                      key: UniqueKey(),
                      imageUrl: widget.message.documentUrl!,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator.adaptive()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                widget.message.message.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          widget.message.message,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    : const SizedBox(
                        height: 4,
                      ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    time,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
