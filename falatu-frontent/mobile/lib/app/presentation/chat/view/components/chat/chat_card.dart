import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/user/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(
      {Key? key,
      required this.otherUser,
      required this.chat,
      required this.onTap})
      : super(key: key);

  final UserEntity? otherUser;
  final ChatEntity chat;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final String time = DateFormat.Hm().format(chat.lastMessageTime!);
    if (otherUser != null) {
      return GestureDetector(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(otherUser!.picture),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${otherUser!.firstName} ${otherUser!.lastName}'),
                    chat.lastMessage != null
                        ? Text(chat.lastMessage!)
                        : const SizedBox.shrink(),
                  ],
                ),
                const Spacer(),
                chat.lastMessage != null
                    ? Align(alignment: Alignment.bottomLeft, child: Text(time))
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
