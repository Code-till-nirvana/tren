import 'package:flutter/material.dart';

import '../state/fit_state.dart';
import '../theme/app_colors.dart';

const kDefaultBanner = AssetImage('assets/img/banner_default.jpg');

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.size = 52});

  static const defaultPhoto = AssetImage('assets/img/tren_default_avatar.jpg');

  final double size;

  @override
  Widget build(BuildContext context) => ListenableBuilder(listenable: fit, builder: (context, _) => _avatar(context));

  Widget _avatar(BuildContext context) {
    final gc = context.gc;
    final bytes = fit.profilePhoto;
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: gc.bgRaised, shape: BoxShape.circle),
      foregroundDecoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: gc.border),
      ),
      child: Image(
        image: bytes != null ? MemoryImage(bytes) : defaultPhoto,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) => DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF632B42), Color(0xFF17171C)],
            ),
          ),
          child: Icon(Icons.fitness_center, size: size * 0.46, color: Colors.white.withValues(alpha: 0.92)),
        ),
      ),
    );
  }
}
