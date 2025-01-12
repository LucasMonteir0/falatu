import 'package:falatu_mobile/commons/utils/guards/auth_guard.dart';
import 'package:falatu_mobile/commons/utils/module.dart';
import 'package:falatu_mobile/commons/utils/routes.dart';
import 'package:falatu_mobile/main.dart';
import 'package:go_router/go_router.dart';

class SignInModule extends Module {
  @override
  void dependencies() {}

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: Routes.signIn,
          builder: (_, __) => SignInPage(),
          redirect: AuthGuard.call(),
        ),
      ];
}
