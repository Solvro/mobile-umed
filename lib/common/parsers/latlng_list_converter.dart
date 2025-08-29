import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "latlng_converter.dart";

const _locationDistanceThresholdInMeters = 5;

class LatLngListConverter implements JsonConverter<IList<LatLng>, List<dynamic>> {
  const LatLngListConverter();

  @override
  IList<LatLng> fromJson(List<dynamic> json) {
    final list =
        json.map((e) {
          final outerMap = e as Map<String, dynamic>;
          final latLngMap = outerMap["location_id"] as Map<String, dynamic>;
          return const LatLngConverter().fromJson(latLngMap);
        }).toList();

    const distance = Distance();
    // TODO(tt): move this somewhere else
    final newCoords = <LatLng>[];
    for (var i = 0; i < list.length - 1; i++) {
      final current = list[i];
      final next = list[i + 1];
      final dist = distance.as(LengthUnit.Meter, current, next).round();
      newCoords.add(current);

      if (dist > _locationDistanceThresholdInMeters) {
        final numSteps = (dist / _locationDistanceThresholdInMeters).floor();
        final bearing = distance.bearing(current, next);

        for (var step = 1; step <= numSteps; step++) {
          final intermediate = distance.offset(current, step * 3, bearing);
          if (distance.as(LengthUnit.Meter, intermediate, next) > 0) {
            newCoords.add(intermediate);
          }
        }
      }

      if (i == list.length - 2) {
        newCoords.add(next);
      }
    }

    return newCoords.lock;
  }

  @override
  List<dynamic> toJson(IList<LatLng> landmarks) {
    return landmarks.map((e) => {"location_id": const LatLngConverter().toJson(e)}).toList();
  }
}
