import "dart:io";
import "package:flutter/material.dart";
import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:latlong2/latlong.dart";
import "../../../common/task_handlers/simple_task_handler.dart";
import "../../../common/utils/location_service.dart";

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Future<void> _requestPermissions() async {
    final NotificationPermission notificationPermission = await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (Platform.isAndroid) {
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }
      if (!await FlutterForegroundTask.canScheduleExactAlarms) {
        await FlutterForegroundTask.openAlarmsAndRemindersSettings();
      }
    }
  }

  void _initService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: "foreground_service",
        channelName: "Foreground Service Notification",
        channelDescription: "This notification appears when the foreground service is running.",
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(showNotification: false),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<ServiceRequestResult> _startService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      final result = FlutterForegroundTask.startService(
        // serviceTypes: [
        //   ForegroundServiceTypes.dataSync,
        //   ForegroundServiceTypes.remoteMessaging,
        // ],
        serviceId: 256,
        notificationTitle: "Foreground Service is running",
        notificationText: "Tap to return to the app",
        notificationButtons: [const NotificationButton(id: "btn_hello", text: "hello")],
        notificationInitialRoute: "/",
        callback: startCallback,
      );
      return result;
    }
  }

  void _sendDataToTask() {
    FlutterForegroundTask.sendDataToTask([
      const LatLng(52.2297, 21.0122).toJson(),
      const LatLng(52.4064, 16.9252).toJson(),
      const LatLng(50.0647, 19.9450).toJson(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Foreground Task")),
      body: Center(
        child: Row(
          children: [
            ElevatedButton(onPressed: _startService, child: const Text("Start Service")),
            ElevatedButton(onPressed: _sendDataToTask, child: const Text("Send Data")),
          ],
        ),
      ),
    );
  }

  void _onReceiveTaskData(Object data) {
    if (data is Map<String, dynamic>) {
      final int? timestampMillis = data["timestampMillis"] as int?;
      if (timestampMillis != null) {
        final DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(timestampMillis, isUtc: true);
        print("timestamp: $timestamp");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _requestPermissions();
      await LocationService.requestPermissions();
      _initService();
    });
  }

  @override
  void dispose() {
    FlutterForegroundTask.removeTaskDataCallback(_onReceiveTaskData);
    super.dispose();
  }
}
