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

  String formatToMessageList(BuildContext context) {
    final now = DateTime.now();
    final locale = Localizations.localeOf(context).toString();

    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(year, month, day);
    final difference = today.difference(date).inDays;
    if (difference == 0) {
      return context.i18n.today;
    } else if (difference == 1) {
      return context.i18n.yesterday;
    } else if (difference < 7) {
      return DateFormat.EEEE(locale).format(this); // Nome do dia da semana
    } else {
      return DateFormat("MMM d, y", locale).format(this); // Ex: Jun 16, 2023
    }
  }

  String toTime() {
    return DateFormat("HH:mm").format(this);
  }

  String toDateAndTime() {
    return DateFormat("dd/MM/yyyy HH:mm").format(this);
  }

  DateTime subtractHours(int hours) {
    return subtract(Duration(hours: hours));
  }
}
