import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

class AppIconStyle {
  const AppIconStyle(this.id, this.design, this.icon, this.base, this.accent);

  final String id;
  final bool design;
  final IconData icon;
  final Color base;
  final Color accent;
}

class AppIcon {
  AppIcon._();

  static const _channel = MethodChannel('com.tren.app/icon');

  static const styles = [
    AppIconStyle('default', false, PhosphorIconsBold.trophy, Color(0xFF17151A), Color(0xFFF08A65)),
    AppIconStyle('light', false, PhosphorIconsBold.barbell, Color(0xFF211B1D), Color(0xFFFFA36C)),
    AppIconStyle('sand', false, PhosphorIconsBold.mountains, Color(0xFF10212A), Color(0xFF59C6E8)),
    AppIconStyle('graphite', false, PhosphorIconsBold.lightning, Color(0xFF1B171D), Color(0xFFFF6C7A)),
    AppIconStyle('sage', false, PhosphorIconsBold.shield, Color(0xFF14231E), Color(0xFFB3C58A)),
    AppIconStyle('night', false, PhosphorIconsBold.fire, Color(0xFF211511), Color(0xFFFF995C)),
    AppIconStyle('material', true, PhosphorIconsBold.personSimpleRun, Color(0xFF171C25), Color(0xFF82B7F4)),
    AppIconStyle('medal', true, PhosphorIconsBold.heartbeat, Color(0xFF201526), Color(0xFFF18CC7)),
    AppIconStyle('glass', true, PhosphorIconsBold.target, Color(0xFF152326), Color(0xFF60D2C1)),
    AppIconStyle('stopwatch', true, PhosphorIconsBold.timer, Color(0xFF20202A), Color(0xFFB7A7FF)),
    AppIconStyle('marble', true, PhosphorIconsBold.columns, Color(0xFF202018), Color(0xFFD7C48C)),
  ];

  static final current = ValueNotifier<String>('default');
  static bool available = false;

  static AppIconStyle get style => styles.firstWhere((s) => s.id == current.value, orElse: () => styles.first);

  static Future<void> load() async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return;
    try {
      current.value = await _channel.invokeMethod<String>('current') ?? 'default';
      available = true;
    } catch (_) {
      available = false;
    }
  }

  static Future<bool> set(String id) async {
    if (!available || id == current.value) return false;
    final before = current.value;
    current.value = id;
    try {
      final ok = await _channel.invokeMethod<bool>('set', {'name': id}) ?? false;
      if (!ok) current.value = before;
      return ok;
    } catch (_) {
      current.value = before;
      return false;
    }
  }
}
