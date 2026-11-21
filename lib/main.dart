import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/tren_app.dart';
import 'services/alarm_store.dart';
import 'services/home_widget_bridge.dart';
import 'services/live_workout.dart';
import 'services/local_store.dart';
import 'services/media_store.dart';
import 'services/app_icon.dart';
import 'services/nfc_tags.dart';
import 'services/graphics_mode.dart';
import 'services/rest_alarm.dart';
import 'services/screen_awake.dart';
import 'state/fit_state.dart';
import 'services/quick_tiles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
  ));

  await initializeDateFormatting();
  await Store.instance.init();
  await MediaStore.init();
  await AlarmStore.init();
  await RestAlarm.instance.init();
  GraphicsMode.load();
  AppIcon.load();
  fit.loadFromStore();
  NfcTags.load();
  fit.syncPhotoReminder();
  fit.syncMeasureReminder();
  fit.syncTrainReminder();

  fit.addListener(_sessionSideEffects);
  _sessionSideEffects();

  fit.onWidgetsShouldUpdate = HomeWidgetBridge.update;
  unawaited(QuickTiles.init());
  runApp(const TrenApp());

  GraphicsMode.watchFirstFrame();
  WidgetsBinding.instance.addPostFrameCallback((_) => HomeWidgetBridge.update());
}

void _sessionSideEffects() {
  LiveWorkout.sync();
  final live = fit.isSessionActive && fit.session?.manual == false;
  ScreenAwake.keepOn(fit.keepScreenOn && live);
}
