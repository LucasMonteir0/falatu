import "package:falatu_mobile/app/core/data/datasources/auth/auth_datasource.dart";
import "package:falatu_mobile/app/core/data/datasources/auth/auth_datasource_impl.dart";
import "package:falatu_mobile/app/core/data/repositories/auth/auth_repository_impl.dart";
import "package:falatu_mobile/app/core/domain/repositories/auth/auth_repository.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_in/sign_in_use_case.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_in/sign_in_use_case_impl.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_up/sign_up_use_case.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_up/sign_up_use_case_impl.dart";
import "package:falatu_mobile/app/ui/blocs/sign_in_bloc.dart";
import "package:falatu_mobile/app/ui/blocs/sign_up_bloc.dart";
import "package:falatu_mobile/app/ui/pages/settings/settings_page.dart";
import "package:falatu_mobile/app/ui/pages/sign_in/sign_in_page.dart";
import "package:falatu_mobile/app/ui/pages/sign_up/sign_up_page.dart";
import "package:falatu_mobile/chat/chat_module.dart";
import "package:falatu_mobile/commons/commons_module.dart";
import "package:falatu_mobile/commons/utils/guards/auth_guard.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter_modular/flutter_modular.dart";

class AppModule extends Module {
  @override
  List<Module> get imports => [CommonsModule()];

  @override
  List<Bind<Object>> get binds => [
        //DATASOURCES
        Bind.factory<AuthDatasource>((i) => AuthDatasourceImpl(i())),

        //REPOSITORIES
        Bind.factory<AuthRepository>((i) => AuthRepositoryImpl(i())),

        //USECASES
        Bind.factory<SignInUseCase>((i) => SignInUseCaseImpl(i())),
        Bind.factory<SignUpUseCase>((i) => SignUpUseCaseImpl(i())),

        //BLOCS
        Bind.factory<SignInBloc>((i) => SignInBloc(i(), i())),
        Bind.factory<SignUpBloc>((i) => SignUpBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Routes.chats, module: ChatModule(), guards: [AuthGuard()]),
        ChildRoute(
          Routes.signIn,
          child: (_, __) => const SignInPage(),
        ),
        ChildRoute(
          Routes.signUp,
          child: (_, __) => const SignUpPage(),
        ),
        ChildRoute(
          Routes.settings,
          child: (_, __) => const SettingsPage(),
        ),
      ];
}
