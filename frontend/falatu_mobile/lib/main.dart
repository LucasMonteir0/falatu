import "package:falatu_mobile/app/app_module.dart";
import "package:falatu_mobile/commons/utils/helpers/url_helpers.dart";
import "package:falatu_mobile/commons/utils/resources/theme/theme.dart";
import "package:falatu_mobile/commons/utils/resources/theme/theme_manager.dart";
import "package:falatu_mobile/falatu.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MaterialTheme.loadTheme();
  await UrlHelpers.init();
  await ThemeManager.i.init();
  await ThemeManager.i.ensureInitialized();
  runApp(ModularApp(module: AppModule(), child: const FalaTu()));
}
