import 'package:flutter/material.dart';

@immutable
class GymColors extends ThemeExtension<GymColors> {
  const GymColors({
    required this.pageBg,
    required this.bg,
    required this.bgRaised,
    required this.bgRaised2,
    required this.border,
    required this.navBg,
    required this.text,
    required this.textSecondary,
    required this.textTertiary,
    required this.ember,
    required this.emberDeep,
    required this.onEmber,
    required this.emberSoft,
    required this.emberShadow,
    required this.accent,
    required this.accentSoft,
    required this.brass,
    required this.sage,
    required this.sageSoft,
    required this.mutedFill,
    required this.heatEmpty,
    required this.info,
    required this.warn,
    required this.danger,
  });

  final Color pageBg;
  final Color bg;
  final Color bgRaised;
  final Color bgRaised2;
  final Color border;
  final Color navBg;
  final Color text;
  final Color textSecondary;
  final Color textTertiary;
  final Color ember;
  final Color emberDeep;
  final Color onEmber;
  final Color emberSoft;
  final Color emberShadow;
  final Color accent;
  final Color accentSoft;
  final Color brass;
  final Color sage;
  final Color sageSoft;
  final Color mutedFill;
  final Color heatEmpty;
  final Color info;
  final Color warn;
  final Color danger;

  static const dark = GymColors(
    pageBg: Color(0xFF202124),
    bg: Color(0xFF202124),
    bgRaised: Color(0xFF29292D),
    bgRaised2: Color(0xFF37363B),
    border: Color(0xFF414047),
    navBg: Color(0xE6202124),
    text: Color(0xFFF1F0EF),
    textSecondary: Color(0xFFB6B2B4),
    textTertiary: Color(0xFF858187),
    ember: Color(0xFF873F50),
    emberDeep: Color(0xFF6F3342),
    onEmber: Color(0xFFF1F0EF),
    emberSoft: Color(0x33873F50),
    emberShadow: Color(0x66873F50),
    accent: Color(0xFFB87988),
    accentSoft: Color(0x33B87988),
    brass: Color(0xFFC99BA4),
    sage: Color(0xFF8FA377),
    sageSoft: Color(0x298FA377),
    mutedFill: Color(0xFF37363B),
    heatEmpty: Color(0xFF29292D),
    info: Color(0xFF7FA8C9),
    warn: Color(0xFFE0B15A),
    danger: Color(0xFFE5674C),
  );

  static const amoled = GymColors(
    pageBg: Color(0xFF080809),
    bg: Color(0xFF080809),
    bgRaised: Color(0xFF151518),
    bgRaised2: Color(0xFF222126),
    border: Color(0xFF343238),
    navBg: Color(0xF2080809),
    text: Color(0xFFF4F1F2),
    textSecondary: Color(0xFFB9B3B6),
    textTertiary: Color(0xFF827B80),
    ember: Color(0xFF873F50),
    emberDeep: Color(0xFF6F3342),
    onEmber: Color(0xFFF4F1F2),
    emberSoft: Color(0x33873F50),
    emberShadow: Color(0x66873F50),
    accent: Color(0xFFB87988),
    accentSoft: Color(0x33B87988),
    brass: Color(0xFFC99BA4),
    sage: Color(0xFF8FA377),
    sageSoft: Color(0x298FA377),
    mutedFill: Color(0xFF222126),
    heatEmpty: Color(0xFF151518),
    info: Color(0xFF7FA8C9),
    warn: Color(0xFFE0B15A),
    danger: Color(0xFFE5674C),
  );

  static const light = GymColors(
    pageBg: Color(0xFFF5F2F1),
    bg: Color(0xFFF8F6F5),
    bgRaised: Color(0xFFFFFFFF),
    bgRaised2: Color(0xFFEDE8E9),
    border: Color(0xFFE3DADD),
    navBg: Color(0xF7F8F6F5),
    text: Color(0xFF242024),
    textSecondary: Color(0xFF625A5F),
    textTertiary: Color(0xFF8D8389),
    ember: Color(0xFF873F50),
    emberDeep: Color(0xFF6F3342),
    onEmber: Color(0xFFFFFFFF),
    emberSoft: Color(0x19873F50),
    emberShadow: Color(0x22873F50),
    accent: Color(0xFF9F596A),
    accentSoft: Color(0x1F9F596A),
    brass: Color(0xFF9C6875),
    sage: Color(0xFF66805D),
    sageSoft: Color(0x1F66805D),
    mutedFill: Color(0xFFEDE8E9),
    heatEmpty: Color(0xFFEDE8E9),
    info: Color(0xFF3268A0),
    warn: Color(0xFF9A6A12),
    danger: Color(0xFFC0392B),
  );

  @override
  GymColors copyWith({
    Color? pageBg,
    Color? bg,
    Color? bgRaised,
    Color? bgRaised2,
    Color? border,
    Color? navBg,
    Color? text,
    Color? textSecondary,
    Color? textTertiary,
    Color? ember,
    Color? emberDeep,
    Color? onEmber,
    Color? emberSoft,
    Color? emberShadow,
    Color? accent,
    Color? accentSoft,
    Color? brass,
    Color? sage,
    Color? sageSoft,
    Color? mutedFill,
    Color? heatEmpty,
    Color? info,
    Color? warn,
    Color? danger,
  }) {
    return GymColors(
      pageBg: pageBg ?? this.pageBg,
      bg: bg ?? this.bg,
      bgRaised: bgRaised ?? this.bgRaised,
      bgRaised2: bgRaised2 ?? this.bgRaised2,
      border: border ?? this.border,
      navBg: navBg ?? this.navBg,
      text: text ?? this.text,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      ember: ember ?? this.ember,
      emberDeep: emberDeep ?? this.emberDeep,
      onEmber: onEmber ?? this.onEmber,
      emberSoft: emberSoft ?? this.emberSoft,
      emberShadow: emberShadow ?? this.emberShadow,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      brass: brass ?? this.brass,
      sage: sage ?? this.sage,
      sageSoft: sageSoft ?? this.sageSoft,
      mutedFill: mutedFill ?? this.mutedFill,
      heatEmpty: heatEmpty ?? this.heatEmpty,
      info: info ?? this.info,
      warn: warn ?? this.warn,
      danger: danger ?? this.danger,
    );
  }

  @override
  GymColors lerp(GymColors? other, double t) {
    if (other == null) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return GymColors(
      pageBg: c(pageBg, other.pageBg),
      bg: c(bg, other.bg),
      bgRaised: c(bgRaised, other.bgRaised),
      bgRaised2: c(bgRaised2, other.bgRaised2),
      border: c(border, other.border),
      navBg: c(navBg, other.navBg),
      text: c(text, other.text),
      textSecondary: c(textSecondary, other.textSecondary),
      textTertiary: c(textTertiary, other.textTertiary),
      ember: c(ember, other.ember),
      emberDeep: c(emberDeep, other.emberDeep),
      onEmber: c(onEmber, other.onEmber),
      emberSoft: c(emberSoft, other.emberSoft),
      emberShadow: c(emberShadow, other.emberShadow),
      accent: c(accent, other.accent),
      accentSoft: c(accentSoft, other.accentSoft),
      brass: c(brass, other.brass),
      sage: c(sage, other.sage),
      sageSoft: c(sageSoft, other.sageSoft),
      mutedFill: c(mutedFill, other.mutedFill),
      heatEmpty: c(heatEmpty, other.heatEmpty),
      info: c(info, other.info),
      warn: c(warn, other.warn),
      danger: c(danger, other.danger),
    );
  }
}

extension GymColorsX on BuildContext {
  GymColors get gc => Theme.of(this).extension<GymColors>()!;
}
