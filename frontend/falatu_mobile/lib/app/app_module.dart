import "package:falatu_mobile/app/core/data/datasources/auth/auth_datasource.dart";
import "package:falatu_mobile/app/core/data/datasources/auth/auth_datasource_impl.dart";
import "package:falatu_mobile/app/core/data/repositories/auth/auth_repository_impl.dart";
import "package:falatu_mobile/app/core/domain/repositories/auth/auth_repository.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_in/sign_in_use_case.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_in/sign_in_use_case_impl.dart";
import "package:falatu_mobile/app/ui/blocs/sign_in_bloc.dart";
import "package:falatu_mobile/app/ui/pages/sign_in/sign_in_page.dart";
import "package:falatu_mobile/app/ui/pages/sign_up/sign_up_page.dart";
import "package:falatu_mobile/commons/commons_module.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter_modular/flutter_modular.dart";

class AppModule extends Module {
  @override
  List<Module> get imports => [CommonsModule()];

  @override
  List<Bind<Object>> get binds => [
        Bind.factory<AuthDatasource>((i) => AuthDatasourceImpl(i())),
        Bind.factory<AuthRepository>((i) => AuthRepositoryImpl(i())),
        Bind.factory<SignInUseCase>((i) => SignInUseCaseImpl(i())),
        Bind.factory<SignInBloc>((i) => SignInBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.signIn,
          child: (_, __) => const SignInPage(),
        ),
        ChildRoute(
          Routes.signUp,
          child: (_, __) => const SignUpPage(),
        ),
      ];
}
