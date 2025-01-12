import 'package:dio/dio.dart';
import 'package:falatu_mobile/commons/core/data/services/http_service/http_service_impl.dart';
import 'package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart';
import 'package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services_impl.dart';
import 'package:falatu_mobile/commons/utils/get_it.dart';
import 'package:falatu_mobile/commons/utils/module.dart';

class CommonsModule extends Module {
  @override
  void dependencies() {
    getIt.registerFactory<SharedPreferencesService>(
        () => SharedPreferencesServiceImpl());
    getIt.registerLazySingleton(
        () => HttpServiceImpl(dio: Dio(), preferences: getIt.get()));
  }
}
