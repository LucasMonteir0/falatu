import "package:falatu_mobile/chat/ui/components/send_message/send_messages_section.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_splash_effect.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:flutter/material.dart";

class SendMessageButton extends StatelessWidget {
  final void Function()? onTap;
  final MessagesHandlerState state;

  const SendMessageButton({required this.state, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FalaTuSplashEffect(
      onTap: onTap,
      child: FalaTuIcon(
        size: 30,
        icon: state.isIdle ? FalaTuIconsEnum.mic : FalaTuIconsEnum.sendFilled,
      ),
    );
  }
}
