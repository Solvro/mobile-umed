import "dart:async";
import "dart:collection";

import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:latlong2/latlong.dart";

import "../utils/location_service.dart";

@pragma("vm:entry-point")
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  StreamSubscription<LatLng?>? _locationSubscription;
  Queue<LatLng> locations = Queue();

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _locationSubscription = LocationService.getLocationStream().listen((latLng) async {
      if (latLng != null) {
        const distance = Distance();
        final meterDistance = distance.as(LengthUnit.Meter, locations.first, latLng);
        if (meterDistance > 50) return;

        await FlutterForegroundTask.updateService(
          notificationTitle: "Jesteś niedaleko celu",
          notificationText: "Lat: ${latLng.latitude.toStringAsFixed(5)}, Lng: ${latLng.longitude.toStringAsFixed(5)}",
        );

        locations.removeFirst();

        if (locations.isEmpty) {
          await FlutterForegroundTask.updateService(
            notificationTitle: "Cel osiągnięty",
            notificationText: "Gratulacje! Osiągnąłeś swój cel.",
          );
          await _locationSubscription?.cancel();
        }
      }
    });
  }

  @override
  Future<void> onRepeatEvent(DateTime timestamp) async {}

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    await _locationSubscription?.cancel();
    print("onDestroy(isTimeout: $isTimeout)");
  }

  @override
  void onReceiveData(Object data) {
    if (data is List) {
      locations = Queue.from(data.map((e) => LatLng.fromJson(e as Map<String, dynamic>)));
    }
  }

  @override
  void onNotificationButtonPressed(String id) {
    print("onNotificationButtonPressed: $id");
  }

  @override
  void onNotificationPressed() {
    print("onNotificationPressed");
  }

  @override
  void onNotificationDismissed() {
    print("onNotificationDismissed");
  }
}
