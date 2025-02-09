import "dart:io";

import "package:falatu_mobile/commons/core/data/services/file_picker_service/file_picker_service.dart";
import "package:falatu_mobile/commons/ui/components/falatu_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class FalaTuImageInput extends FormField<File?> {
  final double? size;
  final void Function(File? file)? onChanged;
  final bool readOnly;

  FalaTuImageInput(
      {super.key,
      this.size,
      this.onChanged,
      this.readOnly = false,
      super.validator})
      : super(
          initialValue: null,
          builder: (field) {
            return _HandleErrorWidget(
              size: size,
              hasError: field.hasError,
              errorText: field.errorText,
              onChanged: (file) {
                field.didChange(file);
                field.validate();
                onChanged?.call(field.value);
              },
              readOnly: readOnly,
            );
          },
        );
}

class _PickImageWidget extends StatefulWidget {
  final double? size;
  final void Function(File? file)? onChanged;
  final bool hasError;
  final bool readOnly;

  const _PickImageWidget({
    required this.readOnly,
    this.size,
    this.onChanged,
    this.hasError = false,
  });

  @override
  State<_PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<_PickImageWidget> {
  bool _isPressed = false;

  late final ValueNotifier<File?> _notifier = ValueNotifier(null);

  Future<void> _pickImage() async {
    final picker = Modular.get<FilePickerService>();
    final result = await picker.imageFromGallery();

    if (result != null) {
      _notifier.value = result;
    }
    widget.onChanged?.call(_notifier.value);
  }

  Future<void> _clearImage() async {
    _notifier.value = null;
    widget.onChanged?.call(_notifier.value);
  }

  double get _size => widget.size ?? 100;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ValueListenableBuilder(
        valueListenable: _notifier,
        builder: (context, file, _) {
          return Column(
            children: [
              Material(
                borderRadius: BorderRadius.circular(100),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  splashColor: colors.primary.withAlpha(60),
                  onTap: widget.readOnly
                      ? null
                      : () async {
                          if (_isPressed) {
                            return;
                          }
                          _isPressed = true;
                          await _pickImage();
                          _isPressed = false;
                        },
                  child: Ink(
                    width: _size,
                    height: _size,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: colors.surfaceContainerLow,
                        border: Border.all(
                          color:
                              widget.hasError ? colors.error : colors.primary,
                        )),
                    child: ClipOval(
                      child: file != null
                          ? Image.file(file, fit: BoxFit.cover)
                          : Center(
                              child: FalaTuIcon(
                                icon: FalaTuIconsEnum.image,
                                color: widget.hasError
                                    ? colors.error
                                    : colors.primary,
                                size: _size / 3,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              if (file != null)
                FalaTuButton(
                  label: context.i18n.clear,
                  type: ButtonType.text,
                  onTap: () => _clearImage(),
                ),
            ],
          );
        });
  }
}

class _HandleErrorWidget extends StatelessWidget {
  final double? size;
  final void Function(File? file)? onChanged;
  final bool hasError;
  final bool readOnly;
  final String? errorText;

  const _HandleErrorWidget({
    required this.hasError,
    required this.readOnly,
    this.errorText,
    this.size,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    if (hasError) {
      return Column(
        children: [
          _PickImageWidget(
            size: size,
            hasError: hasError,
            onChanged: onChanged,
            readOnly: readOnly,
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                errorText!,
                style: typography.bodySmall!.copyWith(color: colors.error),
              ),
            ),
        ],
      );
    }
    return _PickImageWidget(
      size: size,
      hasError: hasError,
      onChanged: onChanged,
      readOnly: readOnly,
    );
  }
}
