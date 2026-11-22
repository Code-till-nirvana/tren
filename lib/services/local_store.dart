import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout.dart';

class Store {
  Store._();
  static final Store instance = Store._();

  static const _key = 'tren_v1';
  static const _legacyKey = 'gymmane_v1';
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Map<String, dynamic> load() {
    final current = _prefs?.getString(_key);
    if (current != null) return decodeState(current);
    final legacy = _prefs?.getString(_legacyKey);
    if (legacy != null) {
      // One-time migration keeps existing TREN installs and workout history intact.
      _prefs?.setString(_key, legacy);
      return decodeState(legacy);
    }
    return {};
  }

  static Map<String, dynamic> decodeState(String? raw) {
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw);
      return decoded is Map<String, dynamic> ? decoded : {};
    } catch (_) {
      return {};
    }
  }

  String? note(String key) => _prefs?.getString('tren_$key') ?? _prefs?.getString('gm_$key');

  void setNote(String key, String value) => _prefs?.setString('tren_$key', value);

  Future<void> save(Map<String, dynamic> data, {Map<String, String> raw = const {}}) async {
    try {
      var text = encode(data);
      for (final e in raw.entries) {
        text = text.replaceFirst(jsonEncode(rawMark(e.key)), e.value);
      }
      await _prefs?.setString(_key, text);
    } catch (e) {
      debugPrint('Store.save failed: $e');
    }
  }

  static String rawMark(String tag) => '\u0000$tag\u0000';

  static String encode(Object? data) {
    try {
      return jsonEncode(data);
    } on JsonUnsupportedObjectError {
      return jsonEncode(finite(data));
    }
  }

  static Object? finite(Object? v) => switch (v) {
        double d when !d.isFinite => 0.0,
        Map m => {for (final e in m.entries) '${e.key}': finite(e.value)},
        List l => [for (final x in l) finite(x)],
        _ => v,
      };

  String exportJson(Map<String, dynamic> data) =>
      const JsonEncoder.withIndent('  ').convert(finite(data));

  String exportCsv(List<LoggedSession> sessions) {
    final rows = StringBuffer(
        'date,exercise,muscle,set,reps,weight_kg,volume_kg,est_1rm_kg,distance_km,duration_s,set_type,rpe,rir,note\n');
    final ordered = [...sessions]..sort((a, b) => a.date.compareTo(b.date));
    for (final s in ordered) {
      final day = s.date.toIso8601String().split('T').first;
      for (final e in s.exercises) {
        for (var i = 0; i < e.sets.length; i++) {
          final st = e.sets[i];
          rows.writeln([
            day,
            _csv(e.name),
            e.primary,
            i + 1,
            st.reps,
            _num(st.weight),
            _num(st.volume),
            _num(st.oneRm),
            st.km == null ? '' : _num(st.km!),
            st.sec ?? '',
            st.kind.name,
            st.rpe == null ? '' : _num(st.rpe!),
            st.rir == null ? '' : _num(st.rir!),
            _csv(st.note),
          ].join(','));
        }
      }
    }
    return rows.toString();
  }

  static String _csv(String v) =>
      v.contains(RegExp('[",\n]')) ? '"${v.replaceAll('"', '""')}"' : v;

  static String _num(double v) => v.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), '');

  Map<String, dynamic>? tryParse(String raw) {
    try {
      final decoded = jsonDecode(raw.trim());
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }
}
