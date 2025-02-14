import "package:falatu_mobile/commons/ui/blocs/sign_out_bloc.dart";
import "package:falatu_mobile/commons/ui/components/falatu_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_scaffold.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FalaTuScaffold(
      hasSafeArea: true,
      body: Center(
        child: FalaTuButton(
          label: "Sair",
          type: ButtonType.text,
          onTap: () => Modular.get<SignOutBloc>().call(),
        ),
      ),
    );
  }
}
