import "package:flutter/material.dart";
import "package:flutter/widgets.dart"
    show FormFieldValidator, TextEditingController;
import "package:intl/intl.dart";

class ValidatorsHelper {
  static FormFieldValidator required(String message) {
    return (value) {
      if (value?.isEmpty ?? true) {
        return message;
      }
      return null;
    };
  }

  static FormFieldValidator<String> number(String message) {
    return (value) {
      if (value?.isEmpty ?? true) {
        return null;
      }
      if (double.tryParse(value!) != null) {
        return null;
      } else {
        return message;
      }
    };
  }


  static FormFieldValidator<String> email(String message) {
    return (value) {
      if (value?.isEmpty ?? true) {
        return null;
      }
      final emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      if (emailRegex.hasMatch(value!)) {
        return null;
      }
      return message;
    };
  }

  static FormFieldValidator<String> multiple(
      List<FormFieldValidator<String>> v) {
    return (value) {
      for (final validator in v) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }


  static FormFieldValidator<String> compare(
      TextEditingController? controller, String message) {
    return (value) {
      final textCompare = controller?.text ?? "";
      if (value == null || textCompare != value) {
        return message;
      }
      return null;
    };
  }


  static FormFieldValidator<String> minLengthValidator(
      int minLength, String message) {
    return (value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (value.length < minLength) {
        return message;
      }
      return null;
    };
  }


  static FormFieldValidator<String> invalidSpecialCharacter(String message) {
    return (value) {
      if (value?.isEmpty ?? true) {
        return null;
      }
      final character = RegExp(r"[@$!%*?&+/#=();:°\|_]");
      if (character.hasMatch(value!)) {
        return message;
      }
      return null;
    };
  }

  static FormFieldValidator<String> onlyLetters(String message) {
    return (value) {
      if (value?.isEmpty ?? true) {
        return null;
      }
      final character = RegExp(r"^[A-zÀ-ú ]*$");
      if (character.hasMatch(value!)) {
        return null;
      }
      return message;
    };
  }

  static FormFieldValidator<String> fullName(String m) {
    return (v) {
      if (v?.isEmpty ?? true) {
        return null;
      }

      if (v != null) {
        if (FullNameValidator.isValid(v.trim())) {
          return null;
        }
      }
      return m;
    };
  }



  static FormFieldValidator<String> invalidFormat(String message) {
    return (value) {
      if (value!.isEmpty) {
        return null;
      }
      if (_isValidDate(value)) {
        return null;
      }
      return message;
    };
  }


  static bool _isValidDate(String dateStr, {String format = "dd/MM/yyyy"}) {
    try {
      DateFormat dateFormat = DateFormat(format);
      dateFormat.parseStrict(dateStr);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class FullNameValidator {
  static const String patttern1 = r"^([\S]+\s[\S+]+)";
  static const String patttern2 = r"[a-zA-Z]+";
  static RegExp regExp1 = RegExp(patttern1);
  static RegExp regExp2 = RegExp(patttern2);

  static bool isValid(String code) {
    var valid = regExp1.hasMatch(code) && regExp2.hasMatch(code);
    return valid;
  }
}
