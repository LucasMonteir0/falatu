import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/commons/blocs/get_user_bloc.dart';
import 'package:falatu/app/commons/config/app_routes.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/user/user_entity.dart';
import 'package:falatu/app/presentation/chat/blocs/chats_events.dart';
import 'package:falatu/app/presentation/chat/blocs/private_chats/get_private_chats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatPageParams {
  final UserEntity user;
  final List<ChatEntity> chats;
  final List<UserEntity> users;

  ChatPageParams({required this.user, required this.chats, required this.users});

}

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key, required this.params}) : super(key: key);

  final ChatPageParams params;

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  late GetUserBloc _getUserBloc;
  late GetPrivateChatsBloc _getPrivateChatsBloc;

  @override
  void initState() {
    super.initState();
    _getUserBloc = Modular.get<GetUserBloc>();
    _getPrivateChatsBloc = Modular.get<GetPrivateChatsBloc>();
    _getUserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () =>
                  Modular.to.pushNamed(AppRoutes.login, arguments: true),
              child: const Text('LOGOUT')),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            BlocConsumer<GetUserBloc, BaseState>(
                bloc: _getUserBloc,
                listener: (context, state) {
                  if (state is SuccessState<UserEntity>) {
                    _getPrivateChatsBloc.add(LoadPrivateChats(state.data.id));
                  }
                },
                builder: (context, state) {
                  if (state is ErrorState) {
                    return const Text('Erro');
                  }
                  if (state is SuccessState<UserEntity>) {
                    return Column(
                      children: [
                        Text(state.data.firstName),
                        const SizedBox(height: 50),
                        BlocBuilder<GetPrivateChatsBloc, BaseState>(
                          bloc: _getPrivateChatsBloc,
                          builder: (context, chatState) {
                            if (chatState is SuccessState<List<ChatEntity>>) {
                              return SizedBox(
                                height: 500,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount: chatState.data.length,
                                  itemBuilder: (context, index) {
                                    final ChatEntity chat =
                                        chatState.data[index];
                                    return Text(chat.lastMessage!);
                                  },
                                ),
                              );
                            }
                            return const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
