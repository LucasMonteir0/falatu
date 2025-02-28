import "dart:async";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services_impl.dart";
import "package:falatu_mobile/commons/utils/enums/locales_enum.dart";
import "package:flutter/material.dart";

class Resources {
  final ThemeMode themeMode;
  final LocalesEnum locale;

  const Resources({
    required this.themeMode,
    required this.locale,
  });

  Resources copyWith({ThemeMode? themeMode, LocalesEnum? locale}) {
    return Resources(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}

class ResourcesManager {
  final SharedPreferencesService _preferences = SharedPreferencesServiceImpl();
  static final ResourcesManager i = ResourcesManager._();

  ResourcesManager._();

  final ValueNotifier<Resources> resourcesNotifier = ValueNotifier(
    const Resources(themeMode: ThemeMode.system, locale: LocalesEnum.english),
  );

  final Completer<void> _initCompleter = Completer<void>();

  Future<void> init() async {
    await _preferences.init();

    final theme = _preferences.getThemeMode() ?? ThemeMode.system;
    final locale = _preferences.getLocale() ?? LocalesEnum.english;

    resourcesNotifier.value = Resources(
      themeMode: theme,
      locale: locale,
    );

    _initCompleter.complete();
  }

  Future<void> ensureInitialized() => _initCompleter.future;

  void setThemeMode(ThemeMode mode) {
    _preferences.setThemeMode(mode);
    resourcesNotifier.value = resourcesNotifier.value.copyWith(themeMode: mode);
  }

  void selectLocale(LocalesEnum locale) {
    _preferences.setLocale(locale);
    resourcesNotifier.value = resourcesNotifier.value.copyWith(locale: locale);
  }

  bool isAlreadySet() {
    final theme = _preferences.getThemeMode();
    final locale = _preferences.getLocale();
    return theme != null && locale != null;
  }
}
