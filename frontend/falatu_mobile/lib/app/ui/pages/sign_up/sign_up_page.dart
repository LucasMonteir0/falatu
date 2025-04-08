import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/app/ui/blocs/sign_up_bloc.dart";
import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/ui/components/falatu_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_image_input.dart";
import "package:falatu_mobile/commons/ui/components/falatu_rounded_back_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_scaffold.dart";
import "package:falatu_mobile/commons/ui/components/falatu_text_input.dart";
import "package:falatu_mobile/commons/ui/components/falatu_toast.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/errors/errors.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/helpers/validators_heper.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final ValueNotifier<String> _passwordNotifier;

  late final SignUpBloc _signUpBloc;
  XFile? _picture;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordNotifier = ValueNotifier("");

    _signUpBloc = Modular.get<SignUpBloc>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final typography = Theme.of(context).textTheme;
    return FalaTuScaffold(
      hasSafeArea: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: FalaTuRoundedBackButton()),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    context.i18n.register,
                    style: typography.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: colors.primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0, top: 8),
                  child: Text(context.i18n.registerSubtitle),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: FalaTuImageInput(
                    onChanged: (file) => _picture = file,
                    validator: ValidatorsHelper.requiredObject(
                        context.i18n.requiredFieldError),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FalaTuTextInput(
                    label: context.i18n.fullNameLabel,
                    controller: _nameController,
                    prefixIcon: FalaTuIconsEnum.personFilled,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: ValidatorsHelper.multiple([
                      ValidatorsHelper.required(
                          context.i18n.requiredFieldError),
                      ValidatorsHelper.fullName(context.i18n.invalidNameError),
                      ValidatorsHelper.maxLengthValidator(
                          16, context.i18n.fullNameMaxCharactersError),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FalaTuTextInput(
                    label: context.i18n.emailLabel,
                    prefixIcon: FalaTuIconsEnum.mailFilled,
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: ValidatorsHelper.multiple([
                      ValidatorsHelper.required(
                          context.i18n.requiredFieldError),
                      ValidatorsHelper.email(context.i18n.invalidEmailError),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FalaTuTextInput(
                    label: context.i18n.passwordLabel,
                    prefixIcon: FalaTuIconsEnum.lockFilled,
                    controller: _passwordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) => _passwordNotifier.value = value,
                    validator: ValidatorsHelper.multiple([
                      ValidatorsHelper.required(
                          context.i18n.requiredFieldError),
                      ValidatorsHelper.weekPassword(
                          context.i18n.weekPasswordError)
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FalaTuTextInput(
                    label: context.i18n.confirmPasswordLabel,
                    prefixIcon: FalaTuIconsEnum.lockFilled,
                    controller: _confirmPasswordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: ValidatorsHelper.multiple([
                      ValidatorsHelper.required(
                          context.i18n.requiredFieldError),
                      ValidatorsHelper.compare(_passwordController,
                          context.i18n.differentPasswordsError),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: ValueListenableBuilder(
                    valueListenable: _passwordNotifier,
                    builder: (context, password, _) {
                      return _PasswordCriteria(password: password);
                    },
                  ),
                ),
                BlocConsumer<SignUpBloc, BaseState>(
                  bloc: _signUpBloc,
                  listener: (context, state) {
                    if (state is SuccessState<UserEntity>) {
                      Modular.to.pop();
                      FalaTuToast.show(context,
                          message: context.i18n.onUserCreationMessage,
                          status: FalaTuToastStatus.success);
                    } else if (state is ErrorState<ConflictError>) {
                      FalaTuToast.show(context,
                          message: context.i18n.emailAlreadyInUseMessage);
                    }
                  },
                  builder: (context, state) {
                    return FalaTuButton(
                      label: context.i18n.confirm,
                      isLoading: state is LoadingState,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _signUpBloc.call(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            confirmPassword:
                                _confirmPasswordController.text.trim(),
                            picture: _picture,
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordCriteria extends StatelessWidget {
  final String password;

  _PasswordCriteria({required this.password});

  final RegExp _digitRegex = RegExp(r"\d");
  final RegExp _upperAndLowCaseLetterRegex = RegExp(r"(?=.*[a-z])(?=.*[A-Z])");
  final RegExp _specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        spacing: 4,
        children: [
          _PasswordTile(
              label: context.i18n.atLeastSixCharacters,
              validation: password.length >= 6),
          _PasswordTile(
              label: context.i18n.shouldHaveAtLeastOneDigit,
              validation: _digitRegex.hasMatch(password)),
          _PasswordTile(
              label: context.i18n.shouldHaveBothUpperAndLowerCaseLetters,
              validation: _upperAndLowCaseLetterRegex.hasMatch(password)),
          _PasswordTile(
              label: context.i18n.shouldHaveAtLeastOneSpecialCharacter,
              validation: _specialCharacterRegex.hasMatch(password)),
        ],
      ),
    );
  }
}

class _PasswordTile extends StatelessWidget {
  final String label;
  final bool validation;

  const _PasswordTile({required this.label, required this.validation});

  FalaTuIconsEnum _getIcon() {
    if (validation) {
      return FalaTuIconsEnum.checkCircleOutlined;
    }
    return FalaTuIconsEnum.closeCircleOutlined;
  }

  Color _getColor(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    if (validation) {
      return Colors.green.shade400;
    }
    return colors.outline;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        FalaTuIcon(
          icon: _getIcon(),
          color: _getColor(context),
          size: 18,
        ),
        Flexible(child: Text(label, maxLines: 2)),
      ],
    );
  }
}
