import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tren/screens/profile_screen.dart';
import 'package:tren/state/fit_state.dart';
import 'package:tren/theme/app_theme.dart';
import 'package:tren/widgets/profile_avatar.dart';

final _png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
);

Widget _profile() => MaterialApp(
      theme: AppTheme.dark,
      home: const Scaffold(body: ProfileScreen()),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    fit.clearProfileBanner();
    fit.persistNow();
  });

  test('the default profile cover is bundled', () async {
    final asset = await rootBundle.load(kDefaultBanner.assetName);
    expect(asset.lengthInBytes, greaterThan(0));
  });

  testWidgets(
    'profile uses the TREN cover by default and switches to a custom cover live',
    (tester) async {
      fit.clearProfileBanner();
      await tester.pumpWidget(_profile());
      expect(
        find.byWidgetPredicate((widget) => widget is Image && widget.image == kDefaultBanner),
        findsOneWidget,
      );

      fit.setProfileBanner(_png);
      await tester.pump();
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is MemoryImage &&
              listEquals((widget.image as MemoryImage).bytes, _png),
        ),
        findsOneWidget,
      );
    },
  );
}
