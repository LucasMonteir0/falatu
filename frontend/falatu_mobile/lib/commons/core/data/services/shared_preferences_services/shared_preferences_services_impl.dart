import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/utils/enums/locales_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:flutter/material.dart";
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
    final token = _prefs?.getString("accessToken");
    return token;
  }

  @override
  String? getUserRefreshToken() {
    final token = _prefs?.getString("refreshToken");
    return token;
  }

  @override
  Future<bool> setUserAccessToken(String token) async {
    final isSaved = await _prefs?.setString("accessToken", token);
    return isSaved ?? false;
  }

  @override
  Future<bool> setUserRefreshToken(String token) async {
    final isSaved = await _prefs?.setString("refreshToken", token) ?? false;
    return isSaved;
  }

  @override
  String? getUserId() {
    final token = _prefs?.getString("userId");
    return token;
  }

  @override
  Future<bool> setUserId(String id) async {
    final isSaved = await _prefs?.setString("userId", id) ?? false;
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
    final String? mode = _prefs?.getString("themeMode");
    return mode.let((m) => ThemeMode.values.firstWhere((e) => e.name == m));
  }

  @override
  Future<bool> setThemeMode(ThemeMode mode) async {
    return await _prefs?.setString("themeMode", mode.name) ?? false;
  }

  @override
  LocalesEnum? getLocale() {
    final String? locale = _prefs?.getString("locale");
    return locale.let((m) => LocalesEnum.values.firstWhere((e) => e.name == m));
  }

  @override
  Future<bool> setLocale(LocalesEnum locale) async {
    return await _prefs?.setString("locale", locale.name) ?? false;
  }

  @override
  XFile? getFile(String key) {
    return _prefs?.getString(key).let((p) => XFile(p));
  }

  @override
  Future<bool> setFile(String key, String path) async {
    return await _prefs?.setString(key, path) ?? false;
  }
}
