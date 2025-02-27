import "package:flutter/material.dart";

class RoundBackgroundContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final Gradient? gradient;

  const RoundBackgroundContainer({
    super.key,
    this.child,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(color: color, gradient: gradient),
      child: ClipPath(
        clipper: BottomRoundedClipper(),
        child: child,
      ),
    );
  }
}

class BottomRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height - 50)
      ..quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height - 50,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BackgroundPainter extends CustomPainter {
  final Color? color;
  final Gradient? gradient;

  BackgroundPainter({this.color, this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    if (gradient != null) {
      paint.shader =
          gradient!.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    } else {
      paint.color = color ?? Colors.blue;
    }

    final path = Path()
      ..lineTo(0, size.height - 50)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 50)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
