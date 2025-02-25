import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_splash_effect.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:flutter/material.dart";

class MessageInput extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;

  const MessageInput(
      {super.key, this.controller, this.focusNode, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FalaTuSplashEffect(
              size: 36,
              onTap: () {},
              backgroundColor: colors.primary,
              borderRadius: BorderRadius.circular(100),
              padding: const EdgeInsets.all(4),
              child: FalaTuIcon(
                icon: FalaTuIconsEnum.add,
                color: colors.surfaceBright,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLines: 3,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: _inputDecoration(context),
                  style: typography.bodyMedium,
                  textAlignVertical: TextAlignVertical.center,
                  onSubmitted: onSubmitted,
                  cursorColor: colors.primary,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return InputDecoration(
      isCollapsed: true,
      filled: true,
      fillColor: Colors.transparent,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 4),
      hintText: context.i18n.writeYourMessage,
      hintStyle: typography.bodyMedium!.copyWith(
        color: colors.onSurface,
      ),
    );
  }
}
