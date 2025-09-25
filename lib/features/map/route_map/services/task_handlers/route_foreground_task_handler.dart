import "dart:async";
import "dart:collection";

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
  int lastBlockedCount = -4;
  Queue<Checkpoint> checkpoints = Queue();
  bool isLoop = false;
  int passed = 0;
  Timer? _timer;
  DateTime? startRouteTimestamp;
  LatLng? startCheckpointCoords;
  bool didWalkAwayFromStart = false;
  LatLng? initialUserlocation;
  LatLng? lastVisitedLocation;
  int distanceWalkedInMeters = 0;

  Future<void> _processLocation(LatLng? latLng) async {
    if (latLng == null) return;
    if (locations.isEmpty) return;

    LatLng? currentLocation;
    bool didReachCurrentLocation = false;
    double bestDistance = double.infinity;

    final endIndex = (isLoop && !didWalkAwayFromStart) ? (locations.length - lastBlockedCount) : locations.length;

    for (final LatLng location in locations.take(endIndex)) {
      final meterDistance = distance.as(LengthUnit.Meter, location, latLng);
      if (meterDistance <= LocalizationConfig.coordProximityThresholdInMeters) {
        if (meterDistance < bestDistance) {
          currentLocation = location;
          bestDistance = meterDistance;
        }
        didReachCurrentLocation = true;
      } else if (didReachCurrentLocation) {
        break;
      }
    }

    _checkCheckpointProximity(latLng);

    if (currentLocation == null) {
      return;
    }

    startRouteTimestamp ??= DateTime.now();

    while (locations.isNotEmpty && currentLocation != locations.first) {
      _updateLocation(currentLocation);
    }

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

  void _checkCheckpointProximity(LatLng currentLocation) {
    if (passed > 0 && checkpoints.first.type == LandmarkType.start) {
      checkpoints.removeFirst();
    }

    if (!didWalkAwayFromStart && startCheckpointCoords != null) {
      final meterDistance = distance.as(LengthUnit.Meter, startCheckpointCoords!, currentLocation);
      didWalkAwayFromStart = meterDistance > LocalizationConfig.didWalkAwayThresholdInMeters;
    }

    final isCheckpointNearby =
        distance.as(LengthUnit.Meter, currentLocation, checkpoints.first.location) <=
        LocalizationConfig.checkpointProximityThresholdInMeters;

    if (checkpoints.isNotEmpty && isCheckpointNearby) {
      if (checkpoints.first.type == LandmarkType.start) {
        startCheckpointCoords = checkpoints.first.location;
        didWalkAwayFromStart = false;
      } else if (checkpoints.first.type == LandmarkType.finish) {
        if (!didWalkAwayFromStart) {
          return;
        }
        locations.clear();
        FlutterForegroundTask.sendDataToMain(ForegroundTaskProtocol.onlyEvent(TaskEvent.routeCompleted).toJson());
      }

      FlutterForegroundTask.sendDataToMain(ForegroundTaskProtocol.onlyEvent(TaskEvent.nextCheckpointReached).toJson());
      checkpoints.removeFirst();
    }
  }

  void _saveLastLocation(LatLng location) {
    if (lastVisitedLocation != null) {
      distanceWalkedInMeters += distance.as(LengthUnit.Meter, lastVisitedLocation!, location).round();
    }
    lastVisitedLocation = location;
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (startRouteTimestamp == null) return;
      final elapsed = DateTime.now().difference(startRouteTimestamp!);
      if (elapsed.inSeconds == 0) return;
      FlutterForegroundTask.sendDataToMain(
        ForegroundTaskProtocol.onlyDurationStats(elapsed, distanceWalkedInMeters).toJson(),
      );
    });

    initialUserlocation = await LocationService.getCurrentLatLng();

    _locationSubscription = LocationService.getLocationStream().listen((latLng) async {
      if (latLng == null) return;
      _saveLastLocation(latLng);
      await _processLocation(latLng);
    });
  }

  void _updateLocation(LatLng currentLocation) {
    FlutterForegroundTask.sendDataToMain(ForegroundTaskProtocol.onlyEvent(TaskEvent.nextLocationReached).toJson());
    locations.removeFirst();
    passed++;
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
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
      }

      if (data[ForegroundTaskKeys.checkpoints] is List) {
        checkpoints = Queue.from(
          (data[ForegroundTaskKeys.checkpoints] as List).map((e) => Checkpoint.fromJson(e as Map<String, dynamic>)),
        );
        startCheckpointCoords = checkpoints.firstWhere((element) => element.type == LandmarkType.start).location;
      }

      if (checkpoints.length > 1) {
        isLoop =
            distance.as(LengthUnit.Meter, checkpoints.first.location, checkpoints.last.location) <=
            LocalizationConfig.loopProximityThresholdInMeters;
        if (isLoop) {
          int newLastBlockedCount = 0;

          final lastIndex = locations.length - 1;
          int index = lastIndex;

          while (index >= 0 &&
              distance.as(LengthUnit.Meter, locations.elementAt(index), locations.elementAt(lastIndex)) <=
                  LocalizationConfig.blockLastThreshouldInMeters) {
            newLastBlockedCount++;
            index--;
          }

          lastBlockedCount = newLastBlockedCount;
        }
      }
    }

    if (initialUserlocation != null) {
      unawaited(Future.microtask(() => _processLocation(initialUserlocation)));
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}
}

abstract class ForegroundTaskKeys {
  static const locations = "locations";
  static const checkpoints = "checkpoints";
}
