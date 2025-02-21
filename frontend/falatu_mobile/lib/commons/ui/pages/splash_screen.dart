import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _Splash(),
    );
  }
}
class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF584CD7),
      body: Center(
        child: Lottie.asset(
            width: 225,
            "assets/lottie/falatu_splash_animation_white.json",
            filterQuality: FilterQuality.high,
            repeat: false,
            fit: BoxFit.contain),
      ),
    );
  }
}


