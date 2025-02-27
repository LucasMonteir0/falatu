import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:flutter/cupertino.dart";

enum LocalesEnum {
  portuguese,
  english;

  Locale get getLocale {
    switch(this) {
      case LocalesEnum.portuguese:
       return const Locale("pt");
      case LocalesEnum.english:
        return const Locale("en");
    }
  }

  String getTranslate(BuildContext context) {
    switch(this) {
      case LocalesEnum.portuguese:
        return context.i18n.portuguese;
      case LocalesEnum.english:
        return context.i18n.english;
    }
  }
}