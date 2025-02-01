import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter_modular/flutter_modular.dart";

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: Routes.signIn);

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final preferences = Modular.get<SharedPreferencesService>();
    await preferences.init();
    final accessToken = preferences.getUserAccessToken();
    final refreshToken = preferences.getUserRefreshToken();
    final isLogged = (accessToken != null && accessToken.isNotEmpty) &&
        (refreshToken != null && refreshToken.isNotEmpty);
    return isLogged;
  }
}
