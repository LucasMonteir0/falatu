import 'package:falatu_mobile/app_module.dart';
import 'package:falatu_mobile/commons/utils/extensions/context_extensions.dart';
import 'package:falatu_mobile/commons/utils/resources/localizations/app_localizations.dart';
import 'package:falatu_mobile/commons/utils/resources/theme/theme.dart';
import 'package:falatu_mobile/commons/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FalaTu extends StatelessWidget {
  const FalaTu({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme.loadTextTheme(context);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.i18n.appName,
      theme: MaterialTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(initialLocation: Routes.signIn, routes: AppModule().routes),
    );
  }
}
