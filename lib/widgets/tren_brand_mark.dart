import 'package:flutter/material.dart';

/// Crisp, resolution-independent TREN brand mark for in-app hero surfaces.
class TrenBrandMark extends StatelessWidget {
  const TrenBrandMark({super.key, this.opacity = 1});

  final double opacity;

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: opacity.clamp(0, 1),
        child: const CustomPaint(
          size: Size.square(176),
          painter: _TrenBrandMarkPainter(),
        ),
      );
}

class _TrenBrandMarkPainter extends CustomPainter {
  const _TrenBrandMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 100;
    canvas.save();
    canvas.scale(scale, size.height / 100);

    final mark = Path()
      ..moveTo(8, 18)
      ..lineTo(92, 18)
      ..lineTo(78, 39)
      ..lineTo(60, 39)
      ..lineTo(60, 70)
      ..lineTo(50, 83)
      ..lineTo(40, 70)
      ..lineTo(40, 39)
      ..lineTo(22, 39)
      ..close();

    canvas.drawShadow(mark, const Color(0x663D1020), 3.5, true);
    canvas.drawPath(
      mark,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE17A91), Color(0xFFB84965), Color(0xFF641D35)],
          stops: [0, 0.48, 1],
        ).createShader(const Rect.fromLTWH(8, 18, 84, 65)),
    );

    final bevel = Path()
      ..moveTo(8, 18)
      ..lineTo(92, 18)
      ..lineTo(86, 27)
      ..lineTo(14, 27)
      ..close();
    canvas.drawPath(
      bevel,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0x66FFFFFF), Color(0x00FFFFFF)],
        ).createShader(const Rect.fromLTWH(8, 18, 84, 10)),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _TrenBrandMarkPainter oldDelegate) => false;
}
