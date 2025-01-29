import 'package:falatu_mobile/commons/ui/components/falatu_text_input.dart';
import 'package:falatu_mobile/commons/utils/enums/icons_enum.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                color: Colors.red,
                width: 50,
                height: 50,
              ),
              FalaTuTextInput(
                label: 'E-mail',
                suffixIcon: FalaTuIconsEnum.mailOutlined,
              ),
              FalaTuTextInput(
                label: 'Senha',
                suffixIcon: FalaTuIconsEnum.mailOutlined,
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
