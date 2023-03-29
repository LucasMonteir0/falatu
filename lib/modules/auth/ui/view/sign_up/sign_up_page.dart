import 'package:falatu/shared/config/auth_routes.dart';
import 'package:falatu/modules/auth/ui/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final emailConfirmController = TextEditingController();
    final passwodController = TextEditingController();
    final passwodConfirmController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: firstNameController,
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
                controller: emailConfirmController,
              ),
              // confirm email
              // TextField(
              //   controller: passwodController,
              // ),
              //password
              TextField(
                controller: passwodConfirmController,
              ),

              ElevatedButton(
                onPressed: ()
                { SignUpController().registerUser(
                    emailConfirmController.text,
                    passwodConfirmController.text,
                    firstNameController.text);

                  //Push and replacement n funcionou os argumentos
                  Modular.to.popAndPushNamed('${AuthRoutes.root}${AuthRoutes.login}', arguments: true);
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
