import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:flutter/material.dart";

class CurvedImage extends StatelessWidget {
  final FalaTuImagesEnum image;
  final double height;
  final Color? shadowColor;

  const CurvedImage(
      {required this.image, required this.height, super.key, this.shadowColor});

  static const String _path = "assets/images/";

  static final CurvedClipper _clipper = CurvedClipper();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BoxShadowPainter(
          _clipper.getClip(Size(MediaQuery.of(context).size.width, height)),
          shadowColor ?? Colors.black45,
          3),
      child: ClipPath(
        clipper: _clipper,
        child: Image.asset(
          _path + image.value,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
        ),
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Inicia no canto superior esquerdo
    path.lineTo(0, size.height * 0.95);

    // Primeira onda (subida)
    path.quadraticBezierTo(
      size.width * 0.25, size.height, // Ponto de controle 1
      size.width * 0.5, size.height * 0.8, // Ponto final da 1ª curva
    );

    // Segunda onda (descida)
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.6, // Ponto de controle 2
      size.width, size.height * 0.65, // Ponto final da 2ª curva
    );

    // Fecha o recorte no canto inferior direito
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BoxShadowPainter extends CustomPainter {
  final Path path;
  final Color color;
  final double elevation;

  BoxShadowPainter(
    this.path,
    this.color,
    this.elevation,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawShadow(path, color, elevation, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
