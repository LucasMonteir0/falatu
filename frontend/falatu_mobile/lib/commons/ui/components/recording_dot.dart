import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

class RecordingDot extends StatelessWidget {
  final double? size;
  const RecordingDot({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/lottie/recording_dot.json",
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
