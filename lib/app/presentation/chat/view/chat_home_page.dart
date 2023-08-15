import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/commons/blocs/get_user_bloc.dart';
import 'package:falatu/app/commons/config/app_routes.dart';
import 'package:falatu/app/presentation/chat/blocs/chats_events.dart';
import 'package:falatu/app/presentation/chat/blocs/private_chats/get_private_chats_bloc.dart';
import 'package:falatu/app/presentation/chat/view/components/chats_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  if (state is SuccessState<UsersReturn>) {
                    _getPrivateChatsBloc
                        .add(LoadPrivateChats(state.data.currentUser.id));
                  }
                },
                builder: (context, state) {
                  if (state is ErrorState) {
                    return const Text('Erro');
                  }
                  if (state is SuccessState<UsersReturn>) {
                    return Column(
                      children: [
                        Text(state.data.currentUser.firstName),
                        const SizedBox(height: 50),
                        ChatsComponent(
                            users: state.data.users,
                            currentUser: state.data.currentUser),
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
