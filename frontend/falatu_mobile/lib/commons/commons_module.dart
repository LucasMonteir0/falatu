import "package:dio/dio.dart";
import "package:falatu_mobile/commons/core/data/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/data/services/http_service/http_service_impl.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services_impl.dart";
import "package:flutter_modular/flutter_modular.dart";

class CommonsModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<SharedPreferencesService>(
            (i) => SharedPreferencesServiceImpl(),
            export: true),
        Bind.lazySingleton<HttpService>((i) => HttpServiceImpl(Dio(), i()),
            export: true),
      ];
}
