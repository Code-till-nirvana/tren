import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'home_widget_views.dart';
import 'settings_showcase.dart' show ShowcaseFrame;

class WidgetShowcase extends StatelessWidget {
  const WidgetShowcase({super.key, this.height = 380});

  static void warm(BuildContext context) {}

  final double height;

  static const _gap = 10.0;

  static final _levels = [
    for (var i = 0; i < 7 * 40; i++) const [0, 2, 0, 3, 1, 4, 0, 0, 2, 3, 0, 1, 4, 2][(i * 7 + i ~/ 9) % 14],
  ];

  static const _body = {
    'chest': 0.9,
    'shoulders': 0.6,
    'triceps': 0.7,
    'back': 0.8,
    'biceps': 0.5,
    'quads': 0.75,
    'glutes': 0.55,
    'hamstrings': 0.4,
    'abdomen': 0.3,
  };

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget lift(Widget child) => DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 6))],
          ),
          child: child,
        );
    Widget col(double top, List<Widget> items) => Padding(
          padding: EdgeInsets.only(top: top),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) const SizedBox(height: _gap),
              items[i] is Row || items[i] is Align ? items[i] : lift(items[i]),
            ],
          ]),
        );

    final small = col(0, [
      Align(
        alignment: Alignment.centerRight,
        child: Transform.translate(
          offset: const Offset(6, 0),
          child: lift(TodayWidgetView(gc: gc, done: true, planned: true, streak: 12, size: const Size(112, 112))),
        ),
      ),
      StatsWidgetView(gc: gc, streak: 12, sessionsThisWeek: 3, goalPct: 75, size: const Size(155, 155)),
      TodayWidgetView(gc: gc, done: false, planned: true, streak: 12, size: const Size(155, 155)),
    ]);
    final wide = col(40, [
      HeatmapWidgetView(gc: gc, levels: _levels, streak: 12),
      BodyWidgetView(gc: gc, intensity: _body, days: 7, size: const Size(320, 220)),
      Align(
        alignment: Alignment.centerRight,
        child: lift(TodayWidgetView(gc: gc, done: false, planned: false, rest: true, streak: 12, size: const Size(130, 130))),
      ),
    ]);
    final mixed = Padding(
      padding: const EdgeInsets.only(top: 72),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        lift(StatsWidgetView(gc: gc, streak: 12, sessionsThisWeek: 3, goalPct: 75, size: const Size(155, 172))),
        const SizedBox(height: _gap),
        lift(RotatedBox(
          quarterTurns: 1,
          child: WeekWidgetView(gc: gc, done: const [true, false, true, true, false, true, false], goal: 4, size: const Size(348, 155)),
        )),
      ]),
    );

    return ShowcaseFrame(
      height: height,
      child: ExcludeSemantics(
      child: MediaQuery.withNoTextScaling(
      child: IgnorePointer(
        child: SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: ColoredBox(
              color: gc.bgRaised,
              child: OverflowBox(
                maxWidth: 1000,
                maxHeight: 1000,
                child: Transform.translate(
                  offset: const Offset(16, -26),
                  child: Transform.rotate(
                  angle: -0.16,
                  child: Transform.scale(
                    scale: 0.66,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 155,
                          height: 602,
                          child: OverflowBox(alignment: Alignment.topCenter, maxHeight: double.infinity, child: small),
                        ),
                        const SizedBox(width: _gap),
                        SizedBox(
                          width: 320,
                          height: 602,
                          child: OverflowBox(alignment: Alignment.topCenter, maxHeight: double.infinity, child: wide),
                        ),
                        const SizedBox(width: _gap),
                        mixed,
                      ],
                    ),
                  ),
                ),
                ),
              ),
            ),
          ),
        ),
      ),
      ),
      ),
    );
  }
}
