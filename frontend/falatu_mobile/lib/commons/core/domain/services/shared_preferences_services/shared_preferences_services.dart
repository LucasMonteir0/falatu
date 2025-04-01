import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/commons/utils/enums/locales_enum.dart";
import "package:flutter/material.dart";

abstract class SharedPreferencesService {
  Future<void> init();

  String? getUserId();

  String? getUserAccessToken();

  String? getUserRefreshToken();

  Future<bool> setUserId(String id);

  Future<bool> setUserAccessToken(String token);

  Future<bool> setUserRefreshToken(String token);

  Future<bool> removeAuthCaches();

  Future<bool> setThemeMode(ThemeMode mode);

  ThemeMode? getThemeMode();

  Future<bool> setLocale(LocalesEnum locale);

  LocalesEnum? getLocale();

  Future<bool> setFile(String key, String path);

  XFile? getFile(String key);
}
