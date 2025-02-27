import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/private_chat_entity.dart";
import "package:falatu_mobile/chat/ui/components/chat_tile.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";
import "package:falatu_mobile/chat/utils/strings/tags.dart";
import "package:falatu_mobile/commons/ui/components/falatu_shimmer.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class ChatsListView<T extends ChatEntity> extends StatelessWidget {
  final BaseState state;

  const ChatsListView({required this.state, super.key});

  List<T> _handleChats(BaseState state) {
    return (state as SuccessState<List<ChatEntity>>)
        .data
        .whereType<T>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (state is SuccessState<List<ChatEntity>>) {
          final chats = _handleChats(state);
          if (chats.isEmpty) {
            return Center(child: Text(context.i18n.emptyChatsMessage));
          }
          return ListView.separated(
            itemCount: chats.length,
            separatorBuilder: (_, __) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(height: 4, thickness: 0.1),
            ),
            itemBuilder: (context, index) {
              final chat = chats[index];
              switch (chat.type) {
                case ChatType.private:
                  final private = chat as PrivateChatEntity;
                  return ChatTile(
                    title: private.otherUser.name,
                    pictureUrl: private.otherUser.pictureUrl,
                    lastMessage: chat.lastMessage,
                    tag: Tags.chatTile + private.id,
                    onTap: () => Modular.to.pushNamed(
                        Routes.chats + Routes.privateChat,
                        arguments: chat),
                  );
                case ChatType.group:
                  // TODO: Handle this case.
                  throw UnimplementedError();
              }
            },
          );
        } else if (state is LoadingState) {
          return const _Loading();
        }
        return Text(context.i18n.loadChatsError);
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: List.generate(
            8,
            (index) => const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  FalaTuShimmer.circle(size: 50),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: FalaTuShimmer.rectangle(height: 10)),
                            Spacer()
                          ],
                        ),
                        SizedBox(height: 12),
                        FalaTuShimmer.rectangle(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
