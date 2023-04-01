import 'package:falatu/modules/auth/ui/blocs/register_user_controller.dart';
import 'package:falatu/shared/config/auth_routes.dart';
import 'package:falatu/modules/auth/ui/blocs/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final register = context.watch<RegisterUserController>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: register.firstNameController,
              ),
              // //fist name
              // TextField(
              //   controller: lastNameController,
              // ),
              //last name
              // TextField(
              //   controller: emailController,
              // ),
              //email
              TextField(
                controller: register.emailConfirmController,
              ),
              // confirm email
              // TextField(
              //   controller: passwodController,
              // ),
              //password
              TextField(
                controller: register.passwodConfirmController,
              ),

              ElevatedButton(
                onPressed: () {
                  register(
                    register.emailConfirmController.text,
                    register.passwodConfirmController.text,
                    register.firstNameController.text,
                    register.lastNameController.text,
                    register.userPhoto,
                  );

                  //Push and replacement n funcionou os argumentos
                  Modular.to.popAndPushNamed(
                      '${AuthRoutes.root}${AuthRoutes.login}',
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
