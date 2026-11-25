import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/entrance.dart';
import '../widgets/ui_kit.dart';
import '../widgets/tren_brand_mark.dart';

const kAppVersion = '2.4.0';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    if (embedded) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: riseAll(_content(gc)));
    }
    return RiseScope(
      id: 'about',
      once: false,
      child: SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: riseAll([
            ScreenHeader(
              title: t.about,
              onBack: fit.backFromAbout,
              titleSize: 18,
              titleSpacing: 1,
            ),
            const SizedBox(height: 18),
            ..._content(gc),
          ]),
        ),
      ),
      ),
    );
  }

  List<Widget> _content(GymColors gc) => [
            _hero(gc),
            const SizedBox(height: 20),
            _group(gc, [
              (PhosphorIconsRegular.gift, t.freeForever, t.freeForeverWhy),
              (PhosphorIconsRegular.wifiSlash, t.fullyOffline, t.fullyOfflineWhy),
              (PhosphorIconsRegular.export, t.yoursToTake, t.yoursToTakeWhy),
            ]),
            const SizedBox(height: 18),
            _sectionLabel(gc, t.whatsInside),
            const SizedBox(height: 8),
            _group(gc, [
              (PhosphorIconsRegular.barbell, t.exercisesInside(kExercises.length),
                  t.exercisesInsideWhy),
              (PhosphorIconsRegular.calculator, t.calculatorsInside, t.calculatorsInsideWhy),
              (PhosphorIconsRegular.chartLineUp, t.mathInside, t.mathInsideWhy),
            ]),
            const SizedBox(height: 22),
            _developerCredit(gc),
            const SizedBox(height: 16),
            Text(t.aboutBlurb,
                textAlign: TextAlign.center,
                style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.6)),
            const SizedBox(height: 8),
          ];

  Widget _developerCredit(GymColors gc) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () async {
            // Launch the developer's public GitHub profile.
            // Import url_launcher for the platform hand-off.
            await launchUrl(Uri.parse('https://github.com/Te4Kettle'), mode: LaunchMode.externalApplication);
          },
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            decoration: BoxDecoration(
              color: gc.bgRaised,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: gc.accent.withValues(alpha: 0.28)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gc.bgRaised, Color.lerp(gc.bgRaised, gc.accent, 0.10)!],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: gc.accentSoft,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(PhosphorIconsRegular.githubLogo, color: gc.text, size: 23),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.developedByAnadi,
                          style: AppTheme.f(14, weight: FontWeight.w800, color: gc.text)),
                      const SizedBox(height: 4),
                      Text(t.githubProfileLabel,
                          style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
                    ],
                  ),
                ),
                Icon(PhosphorIconsRegular.arrowSquareOut, color: gc.textTertiary, size: 18),
              ],
            ),
          ),
        ),
      );

  Widget _sectionLabel(GymColors gc, String label) => Text(label.toUpperCase(),
      style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4));

  Widget _hero(GymColors gc) {
    return Container(
      height: 178,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -46,
            bottom: -56,
            child: Container(
              width: 162,
              height: 162,
              decoration: BoxDecoration(color: gc.accentSoft, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            left: 128,
            top: -42,
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(color: gc.emberSoft, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: 6,
            top: 14,
            bottom: 14,
            child: const TrenBrandMark(),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('TREN',
                    style: AppTheme.f(33, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.5)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                  decoration: BoxDecoration(
                    color: gc.bgRaised2,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(t.version(kAppVersion),
                      style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _group(GymColors gc, List<(IconData, String, String)> rows) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                border: i < rows.length - 1
                    ? Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.6)))
                    : null,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1, right: 14),
                    child: SizedBox(
                      width: 22,
                      child: Icon(rows[i].$1, size: 19, color: gc.textSecondary),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rows[i].$2, style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
                        const SizedBox(height: 3),
                        Text(rows[i].$3,
                            style: AppTheme.f(12.5,
                                weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

}
