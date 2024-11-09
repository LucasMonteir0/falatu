import 'package:falatu/app/presentation/auth/blocs/register_user_bloc.dart';
import 'package:falatu/app/commons/config/app_routes.dart';
import 'package:falatu_design_system/falatu_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO INITSTATE
    final register = context.watch<RegisterUserBloc>();
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final emailConfirmController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordConfirmController = TextEditingController();
    const String picture = '';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RegisterTextField(
                labelText: 'First name',
                controller: firstNameController,
              ),
              RegisterTextField(
                labelText: 'Last name',
                controller: lastNameController,
              ),
              RegisterTextField(
                labelText: 'Email',
                controller: emailController,
              ),
              RegisterTextField(
                labelText: 'Confirm email',
                controller: emailConfirmController,
              ),
              RegisterTextField(
                labelText: 'Password',
                controller: passwordController,
              ),
              RegisterTextField(
                labelText: 'Confirm Password',
                controller: passwordConfirmController,
              ),

              ElevatedButton(
                onPressed: () {
                  register(
                    emailController.text,
                    passwordController.text,
                    firstNameController.text,
                    lastNameController.text,
                    picture,
                  );

                  //Push and replacement n funcionou os argumentos
                  Modular.to.popAndPushNamed(
                      AppRoutes.login,
                      arguments: true);
                },
                child: const Text('Registrar'),
              )
              //confirm password
            ],
          ),
        ),
      ),
    );
  }
}
