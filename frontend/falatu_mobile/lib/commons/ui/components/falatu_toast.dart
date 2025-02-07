import "package:flutter/material.dart";
import "package:toastification/toastification.dart";

enum FalaTuToastStatus { error, success, info }

class FalaTuToast {
  static Color _handleStatusColor(
      BuildContext context, FalaTuToastStatus status) {
    final color = Theme.of(context).colorScheme;
    switch (status) {
      case FalaTuToastStatus.error:
        return Colors.red.shade400;
      case FalaTuToastStatus.success:
        return Colors.green.shade400;
      case FalaTuToastStatus.info:
        return color.primary;
    }
  }

  static IconData _handleIcon(FalaTuToastStatus status) {
    switch (status) {
      case FalaTuToastStatus.error:
        return Icons.warning_amber_outlined;
      case FalaTuToastStatus.success:
        return Icons.check_circle_outline_rounded;
      case FalaTuToastStatus.info:
        return Icons.info_outline;
    }
  }

  static ToastificationType _handleType(FalaTuToastStatus status) {
    switch (status) {
      case FalaTuToastStatus.error:
        return ToastificationType.error;
      case FalaTuToastStatus.success:
        return ToastificationType.success;
      case FalaTuToastStatus.info:
        return ToastificationType.info;
    }
  }

  static void show(BuildContext context,
      {required String message,
      FalaTuToastStatus status = FalaTuToastStatus.error}) {
    toastification.show(
      context: context,
      style: ToastificationStyle.flat,
      type: _handleType(status),
      icon: Icon(
        _handleIcon(status),
        color: _handleStatusColor(context, status),
      ),
      description: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
      animationBuilder: (context, animation, alignment, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
      closeOnClick: true,
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.none,
    );
  }
}
