import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/utils/enums/locales_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:flutter/src/material/app.dart";
import "package:shared_preferences/shared_preferences.dart";

class SharedPreferencesServiceImpl implements SharedPreferencesService {
  SharedPreferencesServiceImpl() {
    init();
  }

  SharedPreferences? _prefs;

  @override
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  String? getUserAccessToken() {
    if (_prefs == null) {
      return null;
    }
    final token = _prefs!.getString("accessToken");
    return token;
  }

  @override
  String? getUserRefreshToken() {
    if (_prefs == null) {
      return null;
    }
    final token = _prefs!.getString("refreshToken");
    return token;
  }

  @override
  Future<bool> setUserAccessToken(String token) async {
    if (_prefs == null) {
      return false;
    }
    final isSaved = await _prefs!.setString("accessToken", token);
    return isSaved;
  }

  @override
  Future<bool> setUserRefreshToken(String token) async {
    if (_prefs == null) {
      return false;
    }
    final isSaved = await _prefs!.setString("refreshToken", token);
    return isSaved;
  }

  @override
  String? getUserId() {
    if (_prefs == null) {
      return null;
    }
    final token = _prefs!.getString("userId");
    return token;
  }

  @override
  Future<bool> setUserId(String id) async {
    if (_prefs == null) {
      return false;
    }
    final isSaved = await _prefs!.setString("userId", id);
    return isSaved;
  }

  @override
  Future<bool> removeAuthCaches() async {
    if (_prefs == null) {
      return false;
    }
    final List<bool> futures = await Future.wait([
      _prefs!.remove("userId"),
      _prefs!.remove("refreshToken"),
      _prefs!.remove("accessToken"),
    ]);

    return futures.every((removed) => removed);
  }

  @override
  ThemeMode? getThemeMode() {
    if (_prefs == null) {
      return null;
    }
    final String? mode = _prefs!.getString("themeMode");
    return mode.let((m) => ThemeMode.values.firstWhere((e) => e.name == m));
  }

  @override
  Future<bool> setThemeMode(ThemeMode mode) async {
    if (_prefs == null) {
      return false;
    }
    return await _prefs!.setString("themeMode", mode.name);
  }

  @override
  LocalesEnum? getLocale() {
    if (_prefs == null) {
      return null;
    }
    final String? locale = _prefs!.getString("locale");
    return locale.let((m) => LocalesEnum.values.firstWhere((e) => e.name == m));
  }

  @override
  Future<bool> setLocale(LocalesEnum locale) async {
    if (_prefs == null) {
      return false;
    }
    return await _prefs!.setString("locale", locale.name);
  }
}
