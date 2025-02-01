import "package:falatu_mobile/app/app_module.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/resources/localizations/app_localizations.dart";
import "package:falatu_mobile/commons/utils/resources/theme/theme.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class FalaTu extends StatelessWidget {
  const FalaTu({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(Routes.chats + Routes.root);
    MaterialTheme.loadTextTheme(context);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.i18n.appName,
      theme: MaterialTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
