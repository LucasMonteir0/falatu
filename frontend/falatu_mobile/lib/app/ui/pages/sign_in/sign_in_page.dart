import "package:falatu_mobile/app/ui/blocs/sign_in_bloc.dart";
import "package:falatu_mobile/commons/core/domain/entities/auth_credentials_entity.dart";
import "package:falatu_mobile/commons/ui/components/curved_image.dart";
import "package:falatu_mobile/commons/ui/components/falatu_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_logo.dart";
import "package:falatu_mobile/commons/ui/components/falatu_text_input.dart";
import "package:falatu_mobile/commons/ui/components/falatu_toast.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/helpers/validators_heper.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
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

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<SignInBloc>();

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
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colors.surface,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CurvedImage(
                  image: FalaTuImagesEnum.background,
                  height: MediaQuery.of(context).size.height * 0.3,
                  shadowColor: colors.primary,
                ),
                const FalaTuLogo(height: 60),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(context.i18n.appSubtitle),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: FalaTuTextInput(
                    label: context.i18n.emailLabel,
                    controller: _emailController,
                    prefixIcon: FalaTuIconsEnum.mailFilled,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    validator: ValidatorsHelper.multiple([
                      ValidatorsHelper.required(
                          context.i18n.requiredFieldError),
                      ValidatorsHelper.email(context.i18n.invalidEmailError)
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: FalaTuTextInput(
                    label: context.i18n.passwordLabel,
                    controller: _passwordController,
                    prefixIcon: FalaTuIconsEnum.lockFilled,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    validator: ValidatorsHelper.required(
                        context.i18n.requiredFieldError),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FalaTuButton(
                      label: context.i18n.forgotPassword,
                      type: ButtonType.text,
                    ),
                  ),
                ),
                BlocConsumer<SignInBloc, BaseState>(
                    bloc: _bloc,
                    listener: (context, state) {
                      if (state is SuccessState<AuthCredentialsEntity>) {
                        Modular.to.pushReplacementNamed(Routes.chats + Routes.root);
                      } else if (state is ErrorState<NotFoundError>) {
                        FalaTuToast.show(context,
                            message: context.i18n.invalidEmailOrPassword);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                        child: FalaTuButton(
                          label: context.i18n.signIn,
                          isLoading: state is LoadingState,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _bloc.call(_emailController.text,
                                  _passwordController.text);
                            }
                          },
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.i18n.hasAccount),
                      FalaTuButton(
                        label: context.i18n.clickHere,
                        type: ButtonType.text,
                        onTap: () => Modular.to.pushNamed(Routes.signUp),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
