import 'package:falatu/presentation/auth/blocs/login_bloc.dart';
import 'package:falatu/commons/config/app_routes.dart';
import 'package:falatu/presentation/auth/blocs/sign_out_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.isSignOut}) : super(key: key);

  final bool? isSignOut;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;
  late SignOutBloc _signOutBloc;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _loginBloc = Modular.get<LoginBloc>();
    _signOutBloc = Modular.get<SignOutBloc>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();


      if (widget.isSignOut != null && widget.isSignOut!) {
         _signOutBloc();
        debugPrint('DESLOGOU');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await _loginBloc(
                      _emailController.text, _passwordController.text);
                  Modular.to.pushNamed(AppRoutes.home);
                },
                child: const Text('Login'),
              ),
            ),
            TextButton(
              onPressed: () => Modular.to.pushNamed(AppRoutes.signUp),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
