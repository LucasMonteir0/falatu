import 'package:falatu/shared/config/auth_routes.dart';
import 'package:falatu/modules/auth/ui/view/login/login_page.dart';
import 'package:falatu/modules/auth/ui/view/sign_up/sign_up_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [


  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          AuthRoutes.login,
          child: (context, args) => LoginPage(isSignOut: args.data),
        ),
        ChildRoute(
          AuthRoutes.signUp,
          child: (context, args) => const SignUpPage(),
        ),
      ];
}
