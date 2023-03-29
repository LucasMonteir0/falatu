import 'package:falatu/shared/config/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.isSignOut}) : super(key: key);

  final bool? isSignOut;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSignOut != null && widget.isSignOut!) {
      //TODO funcao deslogar
      debugPrint('DESLOGOU');
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(),
            const TextField(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ),
            TextButton(
              onPressed: () => Modular.to
                  .pushNamed('${AuthRoutes.root}${AuthRoutes.signUp}'),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
