import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../l10n/l10n.dart';
import 'notif_sound.dart';
import 'train_reminder.dart';

class ProgressReminder {
  ProgressReminder._();
  static final ProgressReminder instance = ProgressReminder._();

  static const _id = 1002;
  static const _measureId = 1003;

  final _plugin = FlutterLocalNotificationsPlugin();
  bool enabled = true;

  AndroidNotificationDetails get _android => AndroidNotificationDetails(
        NotifSound.channelOf('progress_photo', SoundGroup.other),
        t.notifPhotoChannel,
        channelDescription: t.notifPhotoChannelWhy,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        playSound: NotifSound.plays(SoundGroup.other),
        sound: NotifSound.soundOf(SoundGroup.other),
      );

  DarwinNotificationDetails get _darwin => const DarwinNotificationDetails(
        presentAlert: true,
        presentBanner: true,
        presentList: true,
        presentSound: true,
      );

  Future<void> scheduleFor(DateTime day, int intervalDays) async {
    if (!enabled) return;
    await cancel();
    if (intervalDays <= 0) return;

    try {
      final when = atLocal(DateTime(day.year, day.month, day.day, 10));
      if (!when.isAfter(tz.TZDateTime.now(tz.local))) return;
      await _plugin.zonedSchedule(
        id: _id,
        title: t.notifPhotoTitle,
        body: t.notifPhotoBody(intervalDays),
        scheduledDate: when,
        notificationDetails: NotificationDetails(android: _android, iOS: _darwin),
        androidScheduleMode: await reminderMode(_plugin),
      );
    } catch (e) {
      debugPrint('No se pudo programar el recordatorio de fotos: $e');
    }
  }

  Future<void> scheduleMeasure(DateTime day, int intervalDays) async {
    if (!enabled) return;
    await cancelMeasure();
    if (intervalDays <= 0) return;
    try {
      final when = atLocal(DateTime(day.year, day.month, day.day, 10, 30));
      if (!when.isAfter(tz.TZDateTime.now(tz.local))) return;
      await _plugin.zonedSchedule(
        id: _measureId,
        title: t.notifMeasureTitle,
        body: t.notifMeasureBody(intervalDays),
        scheduledDate: when,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            NotifSound.channelOf('measures', SoundGroup.other),
            t.notifMeasureChannel,
            channelDescription: t.notifMeasureChannelWhy,
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
            playSound: NotifSound.plays(SoundGroup.other),
            sound: NotifSound.soundOf(SoundGroup.other),
          ),
          iOS: _darwin,
        ),
        androidScheduleMode: await reminderMode(_plugin),
      );
    } catch (e) {
      debugPrint('No se pudo programar el recordatorio de medidas: $e');
    }
  }

  Future<void> cancelMeasure() async {
    if (!enabled) return;
    try {
      await _plugin.cancel(id: _measureId);
    } catch (_) {}
  }

  Future<void> cancel() async {
    if (!enabled) return;
    try {
      await _plugin.cancel(id: _id);
    } catch (_) {}
  }
}
