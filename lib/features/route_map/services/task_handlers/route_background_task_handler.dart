import "dart:async";
import "dart:collection";

import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:latlong2/latlong.dart";

import "../../../../app/config/ui_config.dart";
import "../../../../common/utils/location_service.dart";

class MyTaskHandler extends TaskHandler {
  StreamSubscription<LatLng?>? _locationSubscription;
  Queue<LatLng> locations = Queue();

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _locationSubscription = LocationService.getLocationStream().listen((latLng) async {
      if (latLng != null && locations.isNotEmpty) {
        const distance = Distance();
        LatLng? currentLocation;

        for (final LatLng location in locations) {
          final meterDistance = distance.as(LengthUnit.Meter, location, latLng);
          if (meterDistance <= LocalizationConfig.proximityThresholdInMeters) {
            currentLocation = location;
            break;
          }
        }

        if (currentLocation == null) {
          return;
        }

        while (currentLocation != locations.first) {
          FlutterForegroundTask.sendDataToMain(TaskEvent.nextLocationReached.name);

          locations.removeFirst();
        }

        FlutterForegroundTask.sendDataToMain(TaskEvent.nextLocationReached.name);
        locations.removeFirst();

        if (locations.isEmpty) {
          FlutterForegroundTask.sendDataToMain(TaskEvent.routeCompleted.name);
          await FlutterForegroundTask.updateService(
            notificationTitle: "Dotarłeś do końca trasy",
            notificationText: "Gratulacje, dotarłeś do końca trasy!",
          );
          await _locationSubscription?.cancel();
        } else {
          await FlutterForegroundTask.updateService(
            notificationTitle: "Jesteś niedaleko celu",
            notificationText: "Dotarłeś do punktu: ${locations.first}",
          );
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
    if (data is List) {
      locations = Queue.from(data.map((e) => LatLng.fromJson(e as Map<String, dynamic>)));
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}
}

enum TaskEvent {
  nextLocationReached,
  routeCompleted,
  error;

  factory TaskEvent.fromString(String value) =>
      TaskEvent.values.firstWhere((e) => e.name == value, orElse: () => TaskEvent.error);
}
