import "dart:async";
import "dart:collection";

import "package:flutter/widgets.dart";
import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:latlong2/latlong.dart";

import "../../../../../app/config/ui_config.dart";
import "../../../../../common/models/checkpoint.dart";
import "../../../../../common/utils/location_service.dart";
import "foreground_task_protocol.dart";

const distance = Distance();

class MyTaskHandler extends TaskHandler {
  StreamSubscription<LatLng?>? _locationSubscription;
  Queue<LatLng> locations = Queue();
  LatLng? lastVisitedLocation;
  Queue<Checkpoint> checkpoints = Queue();
  bool isLoop = false;
  int passed = 0;
  Timer? _timer;
  int distanceTravelled = 0;
  LatLng? startCheckpointCoords;
  bool didWalkAwayFromStart = false;

  void _checkCheckpointProximity(LatLng currentLocation) {
    if (!didWalkAwayFromStart && startCheckpointCoords != null) {
      final meterDistance = distance.as(LengthUnit.Meter, startCheckpointCoords!, currentLocation);
      didWalkAwayFromStart = meterDistance > LocalizationConfig.didWalkAwayThresholdInMeters;
    }

    debugPrint("didWalkAwayFromStart: $didWalkAwayFromStart");
    if (checkpoints.isNotEmpty &&
        distance.as(LengthUnit.Meter, currentLocation, checkpoints.first.location) <=
            LocalizationConfig.coordProximityThresholdInMeters) {
      debugPrint("Condition met");

      if (checkpoints.first.type == LandmarkType.start) {
        startCheckpointCoords = checkpoints.first.location;
        didWalkAwayFromStart = false;
      } else if (checkpoints.first.type == LandmarkType.finish) {
        if (!didWalkAwayFromStart) {
          return;
        }
        debugPrint("finish");
        FlutterForegroundTask.sendDataToMain(ForegroundTaskProtocol.onlyEvent(TaskEvent.routeCompleted).toJson());
      }

      FlutterForegroundTask.sendDataToMain(ForegroundTaskProtocol.onlyEvent(TaskEvent.nextCheckpointReached).toJson());
      checkpoints.removeFirst();
    }
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final elapsed = DateTime.now().difference(timestamp);
      if (elapsed.inSeconds == 0) return;
      FlutterForegroundTask.sendDataToMain(
        ForegroundTaskProtocol.onlyDurationStats(elapsed, distanceTravelled).toJson(),
      );
    });

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
          _updateLocation(currentLocation);
        }

        _checkCheckpointProximity(latLng);

        _updateLocation(currentLocation);

        if (locations.isEmpty) {
          FlutterForegroundTask.sendDataToMain(ForegroundTaskProtocol.onlyEvent(TaskEvent.routeCompleted).toJson());
          await FlutterForegroundTask.updateService(
            notificationTitle: "Dotarłeś do końca trasy",
            notificationText: "Gratulacje, dotarłeś do końca trasy!",
          );
          await _locationSubscription?.cancel();
        }
      }
    });
  }

  void _updateLocation(LatLng currentLocation) {
    FlutterForegroundTask.sendDataToMain(ForegroundTaskProtocol.onlyEvent(TaskEvent.nextLocationReached).toJson());
    if (lastVisitedLocation != null && currentLocation != lastVisitedLocation) {
      distanceTravelled += distance.as(LengthUnit.Meter, lastVisitedLocation!, locations.first).round();
      lastVisitedLocation = locations.first;
    }
    locations.removeFirst();
    passed++;
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    debugPrint("onDestroy");
    await _locationSubscription?.cancel();
    _timer?.cancel();
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
        lastVisitedLocation = locations.firstOrNull;
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

abstract class ForegroundTaskKeys {
  static const locations = "locations";
  static const checkpoints = "checkpoints";
}
