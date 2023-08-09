import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/commons/blocs/get_user_bloc.dart';
import 'package:falatu/app/commons/config/app_routes.dart';
import 'package:falatu/app/core/domains/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  late GetUserBloc getUserBloc;

  @override
  void initState() {
    super.initState();
    getUserBloc = Modular.get<GetUserBloc>();
    getUserBloc();
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
            BlocBuilder<GetUserBloc, BaseState>(
                bloc: getUserBloc,
                builder: (context, state) {
                  if (state is ErrorState) {
                    return const Text('Erro');
                  }
                  if (state is SuccessState<UserEntity>) {
                    return Text(state.data.firstName);
                  }
                  return const CircularProgressIndicator();
                }),
            ElevatedButton(onPressed: () {}, child: const Text('teste')),
          ],
        ),
      ),
    );
  }
}
