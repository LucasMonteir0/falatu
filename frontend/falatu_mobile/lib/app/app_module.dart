import "package:dio/dio.dart";
import "package:falatu_mobile/app/core/data/datasources/auth/auth_datasource.dart";
import "package:falatu_mobile/app/core/data/datasources/auth/auth_datasource_impl.dart";
import "package:falatu_mobile/app/core/data/repositories/auth/auth_repository_impl.dart";
import "package:falatu_mobile/app/core/domain/repositories/auth/auth_repository.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_in/sign_in_use_case.dart";
import "package:falatu_mobile/app/core/domain/usecases/sign_in/sign_in_use_case_impl.dart";
import "package:falatu_mobile/app/ui/blocs/sign_in_bloc.dart";
import "package:falatu_mobile/app/ui/pages/sign_in/sign_in_page.dart";
import "package:falatu_mobile/app/ui/pages/sign_up/sign_up_page.dart";
import "package:falatu_mobile/commons/core/data/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/data/services/http_service/http_service_impl.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services_impl.dart";
import "package:falatu_mobile/commons/utils/get_it.dart";
import "package:falatu_mobile/commons/utils/module.dart";
import "package:falatu_mobile/commons/utils/routes.dart";

import "package:go_router/go_router.dart";

class AppModule implements Module {
  final List<Module> _modules = [];

  @override
  void dependencies() {
    //SERVICES
    getIt.registerFactory<Dio>(() => Dio());
    getIt.registerLazySingleton<SharedPreferencesService>(
        () => SharedPreferencesServiceImpl());
    getIt.registerSingleton<HttpService>(HttpServiceImpl());

    //DATASOURCES
    getIt.registerFactory<AuthDatasource>(() => AuthDatasourceImpl());
    //REPOSITORY
    getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl());

    //USECASES
    getIt.registerFactory<SignInUseCase>(() => SignInUseCaseImpl());

    //BLOCS
    getIt.registerFactory<SignInBloc>(() => SignInBloc());

    for (var module in _modules) {
      module.dependencies();
    }
  }

  final List<RouteBase> _routes = [
    GoRoute(
      path: Routes.signIn,
      builder: (_, __) => const SignInPage(),
    ),
    GoRoute(
      path: Routes.signUp,
      builder: (_, __) => const SignUpPage(),
    ),
  ];

  @override
  List<RouteBase> get routes {
    for (var module in _modules) {
      _routes.addAll(module.routes);
    }
    return _routes;
  }
}
