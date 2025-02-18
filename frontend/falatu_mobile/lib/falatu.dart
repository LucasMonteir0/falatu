import "package:falatu_mobile/commons/ui/blocs/sign_out_bloc.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/resources/localizations/app_localizations.dart";
import "package:falatu_mobile/commons/utils/resources/theme/theme.dart";
import "package:falatu_mobile/commons/utils/resources/theme/theme_manager.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class FalaTu extends StatelessWidget {
  const FalaTu({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(Routes.chats + Routes.root);
    MaterialTheme.loadTextTheme(context);
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeManager.i.notifier,
        builder: (context, themeMode, child) {
          return MaterialApp.router(
            onGenerateTitle: (context) => context.i18n.appName,
            themeMode: themeMode,
            theme: MaterialTheme.light(),
            darkTheme: MaterialTheme.dark(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate,
            builder: (context, child) => BlocListener<SignOutBloc, BaseState>(
                bloc: Modular.get<SignOutBloc>(),
                listener: (context, state) {
                  if (state is SuccessState<bool> && state.data) {
                    Modular.to.pushNamedAndRemoveUntil(
                      Routes.signIn,
                      (p0) => false,
                    );
                  }
                },
                child: child),
          );
        });
  }
}
