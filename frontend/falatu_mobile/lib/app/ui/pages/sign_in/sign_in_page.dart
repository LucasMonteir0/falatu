import "package:falatu_mobile/commons/ui/components/falatu_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_text_input.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:flutter/material.dart";

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              spacing: 16.0,
              children: [
                const FalaTuTextInput(
                  label: "E-mail",
                  prefixIcon: FalaTuIconsEnum.mailFilled,
                ),
                const FalaTuTextInput(
                  label: "Senha",
                  prefixIcon: FalaTuIconsEnum.lockFilled,
                  obscureText: true,
                ),
                FalaTuButton(
                  label: 'Login',
                  onTap: () {},
                ),
                const FalaTuButton(
                    label: 'Registrar-se', type: ButtonType.outlined),
                FalaTuButton(
                    label: 'Registrar-se', type: ButtonType.text, onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
