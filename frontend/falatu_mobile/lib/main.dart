import "package:falatu_mobile/app/app_module.dart";
import "package:falatu_mobile/commons/ui/pages/splash_screen.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";
import "package:falatu_mobile/commons/utils/resources/theme/theme.dart";
import "package:falatu_mobile/commons/utils/resources/resources_manager.dart";
import "package:falatu_mobile/falatu.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SplashScreen());
  await Future.wait([
    Future.delayed(const Duration(milliseconds: 3000)),
    MaterialTheme.loadTheme(),
    UrlHelpers.init(),
    ResourcesManager.i.init(),
    ResourcesManager.i.ensureInitialized()
  ]);
  runApp(ModularApp(module: AppModule(), child: const FalaTu()));
}
