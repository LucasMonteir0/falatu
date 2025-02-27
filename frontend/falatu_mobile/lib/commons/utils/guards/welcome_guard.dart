import "package:falatu_mobile/commons/utils/resources/resources_manager.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter_modular/flutter_modular.dart";

class WelcomeGuard extends RouteGuard {
  WelcomeGuard() : super(redirectTo: Routes.welcome);

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    return ResourcesManager.i.isAlreadySet();
  }
}
