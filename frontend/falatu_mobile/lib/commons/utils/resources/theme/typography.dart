part of "theme.dart";

TextTheme _createTextTheme(BuildContext context) {
  const String font = "Poppins";
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme textTheme = baseTextTheme.copyWith(
    displayLarge: baseTextTheme.displayLarge?.copyWith(fontFamily: font),
    displayMedium: baseTextTheme.displayMedium?.copyWith(fontFamily: font),
    displaySmall: baseTextTheme.displaySmall?.copyWith(fontFamily: font),
    headlineLarge: baseTextTheme.headlineLarge?.copyWith(fontFamily: font),
    headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontFamily: font),
    headlineSmall: baseTextTheme.headlineSmall?.copyWith(fontFamily: font),
    titleLarge: baseTextTheme.titleLarge?.copyWith(fontFamily: font),
    titleMedium: baseTextTheme.titleMedium?.copyWith(fontFamily: font),
    titleSmall: baseTextTheme.titleSmall?.copyWith(fontFamily: font),
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontFamily: font),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontFamily: font),
    bodySmall: baseTextTheme.bodySmall?.copyWith(fontFamily: font),
    labelLarge: baseTextTheme.labelLarge?.copyWith(fontFamily: font),
    labelMedium: baseTextTheme.labelMedium?.copyWith(fontFamily: font),
    labelSmall: baseTextTheme.labelSmall?.copyWith(fontFamily: font),
  );

  return textTheme;
}
