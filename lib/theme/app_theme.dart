import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String disp = 'Nunito';
  static const String sans = 'Nunito';
  static const String round = 'Nunito';

  static ThemeData get dark => _build(Brightness.dark, GymColors.dark);
  static ThemeData get amoled => _build(Brightness.dark, GymColors.amoled);
  static ThemeData get light => _build(Brightness.light, GymColors.light);

  static ThemeData _build(Brightness brightness, GymColors gc) {
    final base = ThemeData(brightness: brightness, useMaterial3: true, fontFamily: sans);
    final radius = BorderRadius.circular(16);
    final outline = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: gc.border),
    );
    return base.copyWith(
      scaffoldBackgroundColor: gc.bg,
      canvasColor: gc.bgRaised,
      colorScheme: base.colorScheme.copyWith(
        surface: gc.bgRaised,
        primary: gc.ember,
        onPrimary: gc.onEmber,
        secondary: gc.accent,
        onSecondary: gc.onEmber,
        onSurface: gc.text,
        error: gc.danger,
      ),
      textTheme: base.textTheme.apply(
        fontFamily: sans,
        bodyColor: gc.text,
        displayColor: gc.text,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      dividerColor: gc.border,
      dividerTheme: DividerThemeData(color: gc.border, thickness: 1, space: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: gc.bgRaised2.withValues(alpha: 0.58),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: TextStyle(color: gc.textTertiary, fontFamily: sans),
        labelStyle: TextStyle(color: gc.textSecondary, fontFamily: sans),
        border: outline,
        enabledBorder: outline,
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: gc.accent, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: gc.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: gc.danger, width: 1.4),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: gc.ember,
          foregroundColor: gc.onEmber,
          disabledBackgroundColor: gc.bgRaised2,
          disabledForegroundColor: gc.textTertiary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: TextStyle(fontFamily: sans, fontWeight: FontWeight.w800, letterSpacing: 0.2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: gc.ember,
          foregroundColor: gc.onEmber,
          disabledBackgroundColor: gc.bgRaised2,
          disabledForegroundColor: gc.textTertiary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: TextStyle(fontFamily: sans, fontWeight: FontWeight.w800, letterSpacing: 0.2),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: gc.text,
          side: BorderSide(color: gc.border),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: TextStyle(fontFamily: sans, fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: gc.accent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: TextStyle(fontFamily: sans, fontWeight: FontWeight.w700),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: gc.bgRaised,
        modalBackgroundColor: gc.bgRaised,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: gc.bgRaised2,
        contentTextStyle: TextStyle(color: gc.text, fontFamily: sans, fontWeight: FontWeight.w600),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: gc.accent,
        linearTrackColor: gc.bgRaised2,
        circularTrackColor: gc.bgRaised2,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? gc.onEmber : gc.textTertiary),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? gc.ember : gc.bgRaised2),
        trackOutlineColor: WidgetStatePropertyAll(gc.border),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? gc.ember : Colors.transparent),
        checkColor: WidgetStatePropertyAll(gc.onEmber),
        side: BorderSide(color: gc.textTertiary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? gc.accent : gc.textTertiary),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: gc.ember,
        inactiveTrackColor: gc.bgRaised2,
        thumbColor: gc.accent,
        overlayColor: gc.accent.withValues(alpha: 0.14),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        hourMinuteShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        hourMinuteColor: WidgetStateColor.resolveWith(
            (s) => s.contains(WidgetState.selected) ? gc.accentSoft : gc.bgRaised2),
        hourMinuteTextColor: WidgetStateColor.resolveWith(
            (s) => s.contains(WidgetState.selected) ? gc.accent : gc.text),
        dayPeriodColor: WidgetStateColor.resolveWith(
            (s) => s.contains(WidgetState.selected) ? gc.accentSoft : Colors.transparent),
        dayPeriodTextColor: WidgetStateColor.resolveWith(
            (s) => s.contains(WidgetState.selected) ? gc.accent : gc.textSecondary),
        dayPeriodBorderSide: BorderSide(color: gc.border),
        helpTextStyle: TextStyle(
            fontFamily: sans, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2, color: gc.textSecondary),
        entryModeIconColor: gc.textSecondary,
        cancelButtonStyle: TextButton.styleFrom(foregroundColor: gc.textSecondary),
        confirmButtonStyle: TextButton.styleFrom(foregroundColor: gc.accent),
      ),
      extensions: [gc],
    );
  }

  static TextStyle d(
    double size, {
    FontWeight weight = FontWeight.w700,
    Color? color,
    double? letterSpacing,
    double height = 1.0,
  }) =>
      TextStyle(
        fontFamily: disp,
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  static TextStyle f(
    double size, {
    FontWeight weight = FontWeight.w700,
    Color? color,
    double? letterSpacing,
    double height = 1.15,
  }) =>
      TextStyle(
        fontFamily: round,
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  static TextStyle s(
    double size, {
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? letterSpacing,
    double height = 1.35,
  }) =>
      TextStyle(
        fontFamily: sans,
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );
}
