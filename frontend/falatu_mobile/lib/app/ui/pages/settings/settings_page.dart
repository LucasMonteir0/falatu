import "package:falatu_mobile/commons/ui/blocs/sign_out_bloc.dart";
import "package:falatu_mobile/commons/ui/components/falatu_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_scaffold.dart";
import "package:falatu_mobile/commons/utils/resources/theme/theme_manager.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FalaTuScaffold(
      hasSafeArea: true,
      backgroundColor: colors.surface,
      title: "Configurações",
      body: Center(
        child: Column(
          children: [
            ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeManager.i.notifier,
              builder: (context, themeMode, child) {
                return Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: ThemeManager.i.toggleTheme,
                );
              },
            ),
            FalaTuButton(
              label: "Sair",
              type: ButtonType.text,
              onTap: () => Modular.get<SignOutBloc>().call(),
            ),
          ],
        ),
      ),
    );
  }
}
