import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:flutter/material.dart";

extension ThemeModeExtensions on ThemeMode {
  FalaTuIconsEnum getIcon() {
    switch (this) {
      case ThemeMode.system:
        return FalaTuIconsEnum.systemMode;
      case ThemeMode.light:
        return FalaTuIconsEnum.lightMode;
      case ThemeMode.dark:
        return FalaTuIconsEnum.darkMode;
    }
  }
}
