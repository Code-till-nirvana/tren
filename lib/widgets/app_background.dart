import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'local_image.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.pattern, this.photo, this.dim = 0.55});

  final String pattern;
  final String? photo;
  final double dim;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    if (pattern == 'photo') {
      final path = photo;
      if (path == null) return const SizedBox.shrink();
      final media = MediaQuery.of(context);
      final cacheWidth = (media.size.width * media.devicePixelRatio).round();
      return IgnorePointer(
        child: RepaintBoundary(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: ResizeImage.resizeIfNeeded(cacheWidth, null, localImage(path)),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      gc.bg.withValues(alpha: dim),
                      gc.bg.withValues(alpha: (dim + 0.18).clamp(0.0, 1.0)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (!const {'flow', 'contours', 'rays'}.contains(pattern)) return const SizedBox.shrink();
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size.infinite,
          painter: _BgPainter(pattern: pattern, color: gc.border, accent: gc.accent),
        ),
      ),
    );
  }
}

class _BgPainter extends CustomPainter {
  _BgPainter({required this.pattern, required this.color, required this.accent});

  final String pattern;
  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final short = size.shortestSide;
    final soft = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.4
      ..color = color.withValues(alpha: 0.36);

    if (pattern == 'flow') {
      for (var i = 0; i < 5; i++) {
        final y = size.height * (0.26 + i * 0.115);
        final path = Path()
          ..moveTo(-short * 0.12, y + short * 0.12)
          ..cubicTo(size.width * 0.22, y - short * 0.32, size.width * 0.48, y + short * 0.32,
              size.width * 0.74, y - short * 0.06)
          ..cubicTo(size.width * 0.9, y - short * 0.24, size.width * 1.08, y - short * 0.1,
              size.width * 1.14, y - short * 0.24);
        soft
          ..color = (i.isEven ? accent : color).withValues(alpha: i == 2 ? 0.22 : 0.11)
          ..strokeWidth = i == 2 ? 2.2 : 1.1;
        canvas.drawPath(path, soft);
      }
      final glow = Paint()
        ..shader = RadialGradient(
          colors: [accent.withValues(alpha: 0.10), Colors.transparent],
        ).createShader(Rect.fromCircle(center: Offset(size.width * 0.78, size.height * 0.34), radius: short * 0.48));
      canvas.drawRect(Offset.zero & size, glow);
      return;
    }

    if (pattern == 'contours') {
      for (var i = 0; i < 11; i++) {
        final inset = i * short * 0.055;
        final rect = Rect.fromLTWH(
          size.width * 0.12 + inset * 0.35,
          size.height * 0.18 + inset,
          size.width * 0.92 - inset * 0.45,
          size.height * 0.72 - inset * 1.2,
        );
        final path = Path()
          ..moveTo(rect.left, rect.bottom)
          ..cubicTo(rect.left - short * 0.08, rect.top + short * 0.24,
              rect.left + short * 0.28, rect.top - short * 0.08, rect.center.dx, rect.top)
          ..cubicTo(rect.right - short * 0.22, rect.top + short * 0.04,
              rect.right + short * 0.08, rect.bottom - short * 0.25, rect.right, rect.bottom);
        soft
          ..color = (i % 3 == 0 ? accent : color).withValues(alpha: i % 3 == 0 ? 0.14 : 0.10)
          ..strokeWidth = 1.0;
        canvas.drawPath(path, soft);
      }
      return;
    }

    final center = Offset(size.width * 0.88, size.height * 0.08);
    final radius = size.longestSide * 1.15;
    for (var i = 0; i < 28; i++) {
      final angle = -2.55 + i * 0.055;
      final end = center + Offset(ui.lerpDouble(0, radius, 1)!, 0);
      final p = Offset(center.dx + radius * ui.lerpDouble(0.78, 1.0, i / 27)!.toDouble() * ui.lerpDouble(-0.92, 0.92, i / 27)!, center.dy + radius * (i / 27) * 0.92);
      final path = Path()
        ..moveTo(center.dx + short * 0.06, center.dy + short * 0.04)
        ..quadraticBezierTo(center.dx + short * 0.12, p.dy * 0.38, p.dx, p.dy);
      soft
        ..color = (i % 4 == 0 ? accent : color).withValues(alpha: i % 4 == 0 ? 0.13 : 0.07)
        ..strokeWidth = 1.0;
      canvas.drawPath(path, soft);
    }
  }

  @override
  bool shouldRepaint(_BgPainter old) =>
      old.pattern != pattern || old.color != color || old.accent != accent;
}
