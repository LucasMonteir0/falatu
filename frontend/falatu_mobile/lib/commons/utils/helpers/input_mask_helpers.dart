import 'package:falatu_mobile/commons/utils/enums/input_mask_enum.dart';
import 'package:falatu_mobile/commons/utils/formatters/upper_case_text_formatter.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputMaskHelpers {
  static List<TextInputFormatter> textInputFormatters(List<InputMaskEnum> masks,
      [String? initialText]) {
    List<TextInputFormatter> formatters = [];

    for (var mask in masks) {
      final TextInputFormatter findMask =
          getTextInputFormatter(mask, initialText);
      formatters.add(findMask);
    }

    return formatters;
  }

  static TextInputFormatter getTextInputFormatter(InputMaskEnum mask,
      [String? initialText]) {
    switch (mask) {
      case InputMaskEnum.date:
        return MaskTextInputFormatter(
            mask: '##/##/####',
            filter: {'#': RegExp(r'[0-9]')},
            initialText: initialText);
      case InputMaskEnum.digitsOnly:
        return FilteringTextInputFormatter.digitsOnly;
      case InputMaskEnum.lettersOnly:
        return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
      case InputMaskEnum.name:
        return FilteringTextInputFormatter.allow(
            RegExp(r'''[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ' ]'''));
      case InputMaskEnum.lettersAndDigitsOnly:
        return FilteringTextInputFormatter.allow(
            RegExp(r'''[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ' -.,0-9]'''));
      case InputMaskEnum.upperCase:
       return UpperCaseTextFormatter();
    }
  }
}
