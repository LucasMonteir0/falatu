import 'package:dio/dio.dart';
import 'package:falatu_mobile/commons/core/data/services/http_service/http_service.dart';
import 'package:falatu_mobile/commons/core/data/services/http_service/http_service_impl.dart';
import 'package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart';
import 'package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services_impl.dart';
import 'package:falatu_mobile/commons/utils/get_it.dart';
import 'package:falatu_mobile/commons/utils/module.dart';
import 'package:falatu_mobile/sign_in/sign_in_module.dart';
import 'package:go_router/go_router.dart';

class AppModule implements Module {
  final List<Module> _modules = [SignInModule()];

  @override
  void dependencies() {
    getIt.registerFactory<Dio>(() => Dio());
    getIt.registerLazySingleton<SharedPreferencesService>(
        () => SharedPreferencesServiceImpl());
    getIt.registerSingleton<HttpService>(HttpServiceImpl());

    for (var module in _modules) {
      module.dependencies();
    }
  }

  final List<RouteBase> _routes = [];

  @override
  List<RouteBase> get routes {
    for (var module in _modules) {
      _routes.addAll(module.routes);
    }
    return _routes;
  }
}
