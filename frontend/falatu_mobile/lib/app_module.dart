import 'package:falatu_mobile/commons/utils/module.dart';
import 'package:falatu_mobile/sign_in/sign_in_module.dart';
import 'package:go_router/go_router.dart';

class AppModule implements Module {
  final List<Module> _modules = [SignInModule()];


  @override
  void dependencies() {
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
