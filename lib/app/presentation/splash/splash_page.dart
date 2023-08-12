import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/presentation/splash/blocs/verify_auth_user_bloc.dart';
import 'package:falatu/app/commons/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VerifyAuthUserBloc _verifyAuthUserBloc;

  @override
  void initState() {
    super.initState();
    _verifyAuthUserBloc = Modular.get<VerifyAuthUserBloc>();
    _verifyAuthUserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyAuthUserBloc, BaseState>(
      bloc: _verifyAuthUserBloc,
      listener: (context, state) {
        if (state is SuccessState<bool>) {
          String route = '';
          if (state.data) {
            route = AppRoutes.home;
          } else {
            route = AppRoutes.login;
          }
          Modular.to.pushReplacementNamed(route);
        }
      },
      child: const Scaffold(
        backgroundColor: Colors.blue,
      ),
    );
  }
}
