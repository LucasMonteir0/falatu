import 'package:falatu/modules/auth/core/data/datasources/remote/user_auth/firebase_auth_datasource_impl.dart';
import 'package:falatu/modules/auth/core/data/datasources/remote/user_auth/user_auth_datasource.dart';
import 'package:falatu/modules/auth/core/data/repositories/user_auth/user_auth_repository_impl.dart';
import 'package:falatu/modules/auth/core/domains/repositories/user_auth/user_auth_repository.dart';
import 'package:falatu/modules/auth/core/domains/usecases/user_auth/user_auth_usecase.dart';
import 'package:falatu/modules/auth/core/domains/usecases/user_auth/user_auth_usecase_impl.dart';
import 'package:falatu/modules/auth/ui/blocs/register_user_controller.dart';
import 'package:falatu/shared/config/auth_routes.dart';
import 'package:falatu/modules/auth/ui/view/login/login_page.dart';
import 'package:falatu/modules/auth/ui/view/sign_up/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {

  @override
  List<Bind> get binds => [
    // Package Dependencies

    Bind.factory<FirebaseAuth>((i) => FirebaseAuth.instance),

    // Put here yours DATASOURCES
    Bind.factory<UserAuthDatasource>((i) => FirebaseAuthDatasourceImpl(i(), i())),

    // Put here yours REPOSITORIES
    Bind.factory<UserAuthRepository>((i) => UserAuthRepositoryImpl(i())),

    // Put here yours USECASES
    Bind.factory<UserAuthUseCase>((i) => UserAuthUseCaseImpl(i())),

    // Put here yours BLOCS
    Bind.factory<RegisterUserController>((i) => RegisterUserController(i())),

  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          AuthRoutes.login,
          child: (context, args) => LoginPage(isSignOut: args.data),
        ),
        ChildRoute(
          AuthRoutes.signUp,
          child: (context, args) => const SignUpPage(),
        ),
      ];
}
