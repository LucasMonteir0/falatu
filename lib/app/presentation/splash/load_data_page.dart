import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/commons/blocs/get_user_bloc.dart';
import 'package:falatu/app/commons/config/app_routes.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/user/user_entity.dart';
import 'package:falatu/app/presentation/chat/blocs/chats_events.dart';
import 'package:falatu/app/presentation/chat/blocs/private_chats/get_private_chats_bloc.dart';
import 'package:falatu/app/presentation/chat/view/chat_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoadDataPage extends StatefulWidget {
  const LoadDataPage({Key? key}) : super(key: key);

  @override
  State<LoadDataPage> createState() => _LoadDataPageState();
}

class _LoadDataPageState extends State<LoadDataPage> {
  late GetUserBloc _getUserBloc;
  late GetPrivateChatsBloc _getPrivateChatsBloc;

  @override
  void initState() {
    super.initState();
    _getUserBloc = Modular.get<GetUserBloc>();
    _getPrivateChatsBloc = Modular.get<GetPrivateChatsBloc>();
  }

  UserEntity? _user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<GetUserBloc, BaseState>(
          bloc: _getUserBloc,
          listener: (context, state) {
            if (state is SuccessState<UserEntity>) {
              _user = state.data;
              _getPrivateChatsBloc.add(LoadPrivateChats(state.data.id));
            }
          }),
      BlocListener<GetPrivateChatsBloc, BaseState>(
          bloc: _getPrivateChatsBloc,
          listener: (context, state) {
            if (state is SuccessState<List<ChatEntity>> && _user != null) {
              final ChatPageParams params = ChatPageParams(
                user: _user!,
                chats: state.data,
                users: [],
              );
              Modular.to
                  .pushReplacementNamed(AppRoutes.home, arguments: params);
            }
          }),
    ], child: const SizedBox());
  }
}
