import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tren/l10n/l10n.dart';
import 'package:tren/models/measure.dart';
import 'package:tren/models/report_doc.dart';
import 'package:tren/models/workout.dart';
import 'package:tren/services/local_store.dart';
import 'package:tren/services/plan_pdf.dart';
import 'package:tren/services/report_content.dart';
import 'package:tren/state/fit_state.dart';
import 'package:tren/theme/app_theme.dart';
import 'package:tren/widgets/report_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  DateTime ago(int d, [int hour = 0]) => DateTime(today.year, today.month, today.day - d, hour);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.setUnits('kg');
    setAppLanguage('en');
  });

  void lift(int daysAgo, double kg, {String note = ''}) {
    fit.sessions.add(LoggedSession(
      ago(daysAgo, 19),
      3600,
      [
        LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [
          LoggedSet(5, kg, rpe: 8, note: note),
          LoggedSet(5, kg, kind: SetKind.warmup),
        ]),
      ],
      sleep: 4,
      energy: 3,
    ));
    fit.sessions.sort((a, b) => a.date.compareTo(b.date));
  }

  RangeReport range(int days) => fit.rangeReport(ago(days - 1), today);

  group('informes', () {
    test('entrenamiento: cada entreno con sus series, RPE, tipo y nota', () {
      lift(3, 100, note: 'Felt easy');
      lift(1, 102.5);
      final md = reportMarkdown(reportBlocks(range(7), ReportKind.training));
      expect(md, contains('# ${reportRangeLabel(range(7))}'));
      expect(md, contains('DETAILED TRAINING REPORT'));
      expect(md, contains('## Workout log'));
      expect(md, contains('### ${t.longDate(ago(3))}'));
      expect(md, contains('- 1. 100 kg × 5 @8 — Felt easy'));
      expect(md, contains('(Warm-up)'));
      expect(md, contains('Sleep 4/5'));
      expect(md, isNot(contains('## Food log')));
      expect('### '.allMatches(md).length, 2);
    });

    test('todo: día a día con entreno y peso', () {
      lift(1, 100);
      fit.bodyweight.add(BodyweightEntry(ago(1, 8), 81.4));
      final md = reportMarkdown(reportBlocks(range(7), ReportKind.full));
      expect(md, contains('COMPLETE REPORT'));
      expect(md, contains('## Day by day'));
      final day = md.substring(md.indexOf('### ${t.longDate(ago(1))}'));
      expect(day, contains('Barbell Bench Press'));
      expect(day, contains('- Bodyweight 81.4 kg'));
      expect(md, isNot(contains('## Health')));
    });

    test('el resumen se queda como estaba: sin día a día ni datos personales', () {
      lift(40, 100);
      lift(3, 105);
      final md = reportMarkdown(reportBlocks(range(7), ReportKind.summary));
      expect(md, contains('TRAINING REPORT'));
      expect(md, contains('## New records'));
      expect(md, contains('| Barbell Bench Press | 105 kg |'));
      expect(md, contains('## Exercises'));
      expect(md, isNot(contains('###')));
      final header = reportBlocks(range(7), ReportKind.summary).first as RepHeader;
      expect(header.about, isEmpty);
      final coach = reportBlocks(range(7), ReportKind.training).first as RepHeader;
      expect(coach.about, isNotEmpty);
    });

    test('las medidas del periodo van de la primera a la última', () {
      fit.measures.addAll([
        BodyMeasure(ago(6), 'waist', 84),
        BodyMeasure(ago(1), 'waist', 82),
        BodyMeasure(ago(20), 'waist', 90),
      ]);
      final md = reportMarkdown(reportBlocks(range(7), ReportKind.full));
      expect(md, contains('**84 cm → 82 cm**'));
    });

    test('un nombre con barra no rompe la tabla en Markdown', () {
      final md = reportMarkdown([
        const RepTable(head: ['A|B', 'X'], rows: [['1|2', '3']], widths: [1, 1]),
      ]);
      expect(md, contains(r'| A\|B | X |'));
      expect(md, contains(r'| 1\|2 | 3 |'));
    });

    testWidgets('los tres PDF se generan y el detallado ocupa varias páginas', (tester) async {
      for (var d = 0; d < 20; d++) {
        lift(d, 100);
      }
      for (final kind in ReportKind.values) {
        final bytes = await tester.runAsync(() => buildReportPdf(range(30), kind: kind));
        final text = latin1.decode(bytes!);
        expect(text.startsWith('%PDF-1.4'), isTrue, reason: kind.name);
        final pages = RegExp(r'/Type /Page ').allMatches(text).length;
        if (kind == ReportKind.summary) {
          expect(pages, 1);
        } else {
          expect(pages, greaterThan(2), reason: kind.name);
        }
      }
      await tester.pump(const Duration(seconds: 5));
    });
  });

  testWidgets('la hoja del informe cambia de tipo, recorta a 92 días y copia el Markdown', (tester) async {
    lift(2, 100);
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String;
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 1400);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(theme: AppTheme.dark, home: const Scaffold(body: ReportSheet())));
    expect(find.text('Summary'), findsOneWidget);
    expect(find.text(t.days365), findsOneWidget);
    await tester.tap(find.text(t.days365));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Training'));
    await tester.pumpAndSettle();
    expect(find.text(t.days7), findsOneWidget, reason: 'los detallados van por semanas o meses');
    expect(find.text(t.days365), findsNothing);
    await tester.tap(find.text('Copy as Markdown'));
    await tester.pumpAndSettle();
    expect(copied, contains('DETAILED TRAINING REPORT'));
    expect(copied, contains('## Workout log'));
    await tester.pump(const Duration(seconds: 5));
  });
}
