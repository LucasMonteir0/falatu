import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:flutter/material.dart";

class ChatTile extends StatelessWidget {
  final String title;
  final String? pictureUrl;
  final VoidCallback onTap;

  const ChatTile({
    required this.title,
    required this.pictureUrl,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: pictureUrl
                      .let((url) => DecorationImage(image: NetworkImage(url))),
                ),
                child: const Center(
                  child: Icon(Icons.person_rounded),
                ),
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
