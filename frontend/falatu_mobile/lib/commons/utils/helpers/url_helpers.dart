import "package:flutter_dotenv/flutter_dotenv.dart";

class UrlHelpers {
  UrlHelpers._();

  static Future<void> init() async {
    await dotenv.load();
  }

  static String getApiBaseUrl({required String moduleName, String? path}) {
    String modulePath = "";
    if (moduleName.isNotEmpty) {
      modulePath = "/$moduleName";
    }
    return '${dotenv.env['FALATU_URL'] ?? ''}$modulePath${path != null ? "/$path" : ""}';
  }
}
