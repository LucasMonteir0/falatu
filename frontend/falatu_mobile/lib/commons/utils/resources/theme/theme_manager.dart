import "dart:async";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services_impl.dart";
import "package:flutter/material.dart";

class ThemeManager {
  final SharedPreferencesService _preferences = SharedPreferencesServiceImpl();
  static final ThemeManager i = ThemeManager._();

  ThemeManager._();

  final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);

  final Completer<void> _initCompleter = Completer<void>();

  Future<void> init() async {
    await _preferences.init();
    final savedTheme = _preferences.getThemeMode();
    notifier.value = savedTheme ?? ThemeMode.light;
    _initCompleter.complete();
  }

  Future<void> ensureInitialized() => _initCompleter.future;

  void toggleTheme(bool isDarkMode) {
    final result = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _preferences.setThemeMode(result);
    notifier.value = result;
  }
}
