import 'package:falatu_mobile/commons/utils/get_it.dart';
import 'package:falatu_mobile/commons/utils/guards/auth_guard.dart';
import 'package:falatu_mobile/commons/utils/module.dart';
import 'package:falatu_mobile/commons/utils/routes.dart';
import 'package:falatu_mobile/sign_in/core/data/datasources/auth_datasource.dart';
import 'package:falatu_mobile/sign_in/core/data/datasources/auth_datasource_impl.dart';
import 'package:falatu_mobile/sign_in/core/data/repositories/auth_repository_impl.dart';
import 'package:falatu_mobile/sign_in/core/domain/repositories/auth_repository.dart';
import 'package:falatu_mobile/sign_in/core/domain/usecases/sign_in_use_case.dart';
import 'package:falatu_mobile/sign_in/core/domain/usecases/sign_in_use_case_impl.dart';
import 'package:falatu_mobile/sign_in/ui/blocs/sign_in_bloc.dart';
import 'package:falatu_mobile/sign_in/ui/pages/sign_in_page.dart';
import 'package:go_router/go_router.dart';

class SignInModule extends Module {
  @override
  void dependencies() {
    getIt.registerFactory<AuthDatasource>(() => AuthDatasourceImpl());
    getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl());
    getIt.registerFactory<SignInUseCase>(() => SignInUseCaseImpl());
    getIt.registerFactory<SignInBloc>(() => SignInBloc());
  }

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: Routes.signIn,
          builder: (_, __) => SignInPage(),
          redirect: AuthGuard.call(),
        ),
      ];
}
