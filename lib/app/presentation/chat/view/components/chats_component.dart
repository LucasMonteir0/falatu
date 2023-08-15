import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/commons/config/app_routes.dart';
import 'package:falatu/app/commons/helpers/chat_filter.dart';
import 'package:falatu/app/commons/helpers/get_other_user.dart';
import 'package:falatu/app/commons/widgets/chat_card.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/user/user_entity.dart';
import 'package:falatu/app/presentation/chat/blocs/private_chats/get_private_chats_bloc.dart';
import 'package:falatu/app/presentation/chat/view/private_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatsComponent extends StatefulWidget {
  const ChatsComponent(
      {Key? key, required this.users, required this.currentUser})
      : super(key: key);

  final List<UserEntity> users;
  final UserEntity currentUser;

  @override
  State<ChatsComponent> createState() => _ChatsComponentState();
}

class _ChatsComponentState extends State<ChatsComponent> {
  late GetPrivateChatsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<GetPrivateChatsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPrivateChatsBloc, BaseState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is SuccessState<List<ChatEntity>>) {
          return SizedBox(
            height: 500,
            width: double.infinity,
            child: ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final ChatEntity chat =
                      ChatFilter.chatsWithMessages(state.data)[index];
                  final UserEntity? otherUser = getOtherUser(
                      chat.users, widget.currentUser.id, widget.users);

                  return ChatCard(
                    onTap: () {
                      PrivateChatPageParams params = PrivateChatPageParams(
                          chat: chat, user: widget.currentUser);
                      Modular.to.pushNamed(AppRoutes.chat, arguments: params);
                    },
                    otherUser: otherUser,
                    chat: chat,
                  );
                }),
          );
        }
        return const SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
