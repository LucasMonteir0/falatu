import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter/services.dart" show rootBundle;
import "package:google_fonts/google_fonts.dart";

part "typography.dart";

class MaterialTheme {
  static late TextTheme _textTheme;
  static const String _colorsPath = "assets/design_tokens/theme_colors.json";

  static Future<ColorScheme> _loadColorScheme(
      String path, String scheme) async {
    final jsonString = await rootBundle.loadString(path);
    final Map<String, dynamic> colorMap = json.decode(jsonString);
    return _parseColorScheme(colorMap[scheme]);
  }

  static ColorScheme _parseColorScheme(Map<String, dynamic> colorMap) {
    return ColorScheme(
      brightness: colorMap["brightness"] == "light"
          ? Brightness.light
          : Brightness.dark,
      primary: _parseColor(colorMap["primary"]),
      onPrimary: _parseColor(colorMap["onPrimary"]),
      primaryContainer: _parseColor(colorMap["primaryContainer"]),
      onPrimaryContainer: _parseColor(colorMap["onPrimaryContainer"]),
      secondary: _parseColor(colorMap["secondary"]),
      onSecondary: _parseColor(colorMap["onSecondary"]),
      secondaryContainer: _parseColor(colorMap["secondaryContainer"]),
      onSecondaryContainer: _parseColor(colorMap["onSecondaryContainer"]),
      tertiary: _parseColor(colorMap["tertiary"]),
      onTertiary: _parseColor(colorMap["onTertiary"]),
      tertiaryContainer: _parseColor(colorMap["tertiaryContainer"]),
      onTertiaryContainer: _parseColor(colorMap["onTertiaryContainer"]),
      surface: _parseColor(colorMap["surface"]),
      onSurface: _parseColor(colorMap["onSurface"]),
      surfaceBright: _parseColor(colorMap["surfaceBright"]),
      surfaceContainerLowest: _parseColor(colorMap["surfaceContainerLowest"]),
      surfaceContainerLow: _parseColor(colorMap["surfaceContainerLow"]),
      surfaceContainer: _parseColor(colorMap["surfaceContainer"]),
      surfaceContainerHigh: _parseColor(colorMap["surfaceContainerHigh"]),
      surfaceContainerHighest: _parseColor(colorMap["surfaceContainerHighest"]),
      shadow: _parseColor(colorMap["shadow"]),
      outline: _parseColor(colorMap["outline"]),
      error: _parseColor(colorMap["error"]),
      onError: _parseColor(colorMap["onError"]),
      errorContainer: _parseColor(colorMap["errorContainer"]),
      onErrorContainer: _parseColor(colorMap["onErrorContainer"]),
    );
  }

  static Color _parseColor(String colorString) {
    return Color(int.parse(colorString));
  }

  static ThemeData _theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        textTheme: _textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
      );

  static Future<void> loadTheme() async {
    _colorSchemeLight = await _loadColorScheme(_colorsPath, "light");
    _colorSchemeDark = await _loadColorScheme(_colorsPath, "dark");
  }

  static late ColorScheme _colorSchemeLight;
  static late ColorScheme _colorSchemeDark;

  static ThemeData light() => _theme(_colorSchemeLight);

  static ThemeData dark() => _theme(_colorSchemeDark);

  static loadTextTheme(BuildContext context) {
    _textTheme = _createTextTheme(context);
  }
}
