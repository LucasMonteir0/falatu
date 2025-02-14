import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

extension DateTimeFormatter on DateTime {
  String formatForChat(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(this);
    final locale = Localizations.localeOf(context).toString();

    if (difference.inHours < 24) {
      return DateFormat.Hm(locale).format(this);
    } else if (difference.inHours < 48) {
      return context.i18n.yesterday;
    } else if (difference.inDays < 7) {
      return DateFormat.EEEE(locale).format(this);
    } else {
      return DateFormat("dd/MM/yy").format(this);
    }
  }
}