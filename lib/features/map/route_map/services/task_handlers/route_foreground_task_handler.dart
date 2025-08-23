import "dart:async";
import "dart:collection";

import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:latlong2/latlong.dart";

import "../../../../../app/config/ui_config.dart";
import "../../../../../common/models/checkpoint.dart";
import "../../../../../common/utils/location_service.dart";

const distance = Distance();

class MyTaskHandler extends TaskHandler {
  StreamSubscription<LatLng?>? _locationSubscription;
  Queue<LatLng> locations = Queue();
  Queue<Checkpoint> checkpoints = Queue();
  bool isLoop = false;
  int passed = 0;

  void _checkCheckpointProximity() {
    if (checkpoints.isNotEmpty &&
        distance.as(LengthUnit.Meter, locations.first, checkpoints.first.location) <=
            LocalizationConfig.coordProximityThresholdInMeters) {
      FlutterForegroundTask.sendDataToMain(TaskEvent.nextCheckpointReached.name);

      if (checkpoints.first.type == LandmarkType.finish) {
        FlutterForegroundTask.sendDataToMain(TaskEvent.routeCompleted.name);
      }

      checkpoints.removeFirst();
    }
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _locationSubscription = LocationService.getLocationStream().listen((latLng) async {
      if (latLng != null && locations.isNotEmpty) {
        LatLng? currentLocation;

        final endIndex = (isLoop && passed <= 4) ? (locations.length - 4) : locations.length;

        for (final LatLng location in locations.take(endIndex)) {
          final meterDistance = distance.as(LengthUnit.Meter, location, latLng);
          if (meterDistance <= LocalizationConfig.coordProximityThresholdInMeters) {
            currentLocation = location;
            break;
          }
        }

        if (currentLocation == null) {
          return;
        }

        while (currentLocation != locations.first) {
          _checkCheckpointProximity();

          FlutterForegroundTask.sendDataToMain(TaskEvent.nextLocationReached.name);
          locations.removeFirst();
          passed++;
        }

        _checkCheckpointProximity();

        FlutterForegroundTask.sendDataToMain(TaskEvent.nextLocationReached.name);
        locations.removeFirst();
        passed++;

        if (locations.isEmpty) {
          FlutterForegroundTask.sendDataToMain(TaskEvent.routeCompleted.name);
          await FlutterForegroundTask.updateService(
            notificationTitle: "Dotarłeś do końca trasy",
            notificationText: "Gratulacje, dotarłeś do końca trasy!",
          );
          await _locationSubscription?.cancel();
        } else {
          // await FlutterForegroundTask.updateService(
          //   notificationTitle: "Jesteś niedaleko celu",
          //   notificationText: "Dotarłeś do punktu: ${locations.first}",
          // );
        }
      }
    });
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    await _locationSubscription?.cancel();
  }

  @override
  void onReceiveData(Object data) {
    passed = 0;
    isLoop = false;

    if (data is Map) {
      if (data[ForegroundTaskKeys.locations] is List) {
        locations = Queue.from(
          (data[ForegroundTaskKeys.locations] as List).map((e) => LatLng.fromJson(e as Map<String, dynamic>)),
        );
      }

      if (data[ForegroundTaskKeys.checkpoints] is List) {
        checkpoints = Queue.from(
          (data[ForegroundTaskKeys.checkpoints] as List).map((e) => Checkpoint.fromJson(e as Map<String, dynamic>)),
        );
      }

      if (checkpoints.length > 1) {
        isLoop =
            distance.as(LengthUnit.Meter, checkpoints.first.location, checkpoints.last.location) <=
            LocalizationConfig.loopProximityThresholdInMeters;
      }
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}
}

enum TaskEvent {
  nextLocationReached,
  nextCheckpointReached,
  routeCompleted,
  error;

  factory TaskEvent.fromString(String value) =>
      TaskEvent.values.firstWhere((e) => e.name == value, orElse: () => TaskEvent.error);
}

abstract class ForegroundTaskKeys {
  static const locations = "locations";
  static const checkpoints = "checkpoints";
}
