import 'package:falatu/shared/config/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('${AuthRoutes.root}${AuthRoutes.login}');

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'FalaTu!',
      theme: ThemeData(
        useMaterial3: true,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
