import "dart:io";

import "package:flutter/material.dart" hide Route;
import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../common/models/route.dart";
import "../../../../../common/models/route_stats.dart";
import "../../../../error/widgets/error_snack_bar.dart";
import "../../controllers/route_controller.dart";
import "../../modals/route_completed_modal.dart";
import "../../providers/locations_provider.dart";
import "../../providers/route_stats_provider.dart";
import "../flutter_foreground_task.dart";
import "foreground_task_protocol.dart";

part "foreground_task_service.g.dart";

@Riverpod(keepAlive: true)
FlutterForegroundService foregroundService(Ref ref) => FlutterForegroundService(ref);

class FlutterForegroundService {
  final Ref ref;
  FlutterForegroundService(this.ref);

  Future<void> handleTaskData(Object data, Route route, BuildContext context) async {
    if (data is! Map<String, dynamic>) return;

    final protocol = ForegroundTaskProtocol.fromJson(data);
    if (protocol.isEvent) {
      final event = protocol.event!;
      switch (event) {
        case TaskEvent.nextLocationReached:
          ref.read(passedLocationsProvider.notifier).state++;
        case TaskEvent.nextCheckpointReached:
          ref.read(visitedCountProvider.notifier).incrementVisited();
        case TaskEvent.routeCompleted:
          await showDialog<RouteCompletedModal>(context: context, builder: (context) => const RouteCompletedModal());
          await FlutterForegroundTask.stopService();
        case TaskEvent.error:
          context.showErrorSnackBar("Error: $data");
      }
    } else if (protocol.isStats) {
      ref.read(routeStatsProvider.notifier).updateStats(RouteStatsModel.fromProtocol(protocol));
    }
  }

  static Future<ServiceRequestResult> startMyForegroundService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: "Aplikacja działa w tle i monitoruje Twoją trasę",
        notificationText: "Dotknij, aby wrócić do aplikacji",
        notificationInitialRoute: "/",
        callback: startCallback,
      );
    }
  }

  static void initMyService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: "foreground_service",
        channelName: "Foreground Service Notification",
        channelDescription: "This notification appears when the foreground service is running.",
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(showNotification: false),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWifiLock: true,
      ),
    );
  }

  static Future<void> requestPermissions() async {
    final notificationPermission = await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (Platform.isAndroid) {
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }
    }
  }
}
