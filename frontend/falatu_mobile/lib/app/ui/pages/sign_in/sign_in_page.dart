import "package:falatu_mobile/app/ui/blocs/sign_in_bloc.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/ui/components/falatu_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_text_input.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final SignInBloc _bloc;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<SignInBloc>();

    // _bloc.call('', '');
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                FalaTuTextInput(
                  label: "E-mail",
                  controller: _emailController,
                  prefixIcon: FalaTuIconsEnum.mailFilled,
                ),
                FalaTuTextInput(
                  label: "Senha",
                  controller: _passwordController,
                  prefixIcon: FalaTuIconsEnum.lockFilled,
                  obscureText: true,
                ),
                BlocConsumer<SignInBloc, BaseState>(
                    bloc: _bloc,
                    listener: (context, state) {
                      if (state is SuccessState<AuthCredentialsEntity>) {
                        Modular.to.pushReplacementNamed(Routes.chats);
                      }
                      if (state is ErrorState) {
                        print(state.error.message);
                      }
                    },
                    builder: (context, state) {
                      return FalaTuButton(
                        label: "Entrar",
                        onTap: () => _bloc.call(
                            _emailController.text, _passwordController.text),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
