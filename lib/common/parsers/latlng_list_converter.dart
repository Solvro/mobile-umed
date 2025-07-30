import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "latlng_converter.dart";

class LatLngListConverter
    implements JsonConverter<IList<LatLng>, List<dynamic>> {
  const LatLngListConverter();

  @override
  IList<LatLng> fromJson(List<dynamic> json) {
    final list = json.map((e) {
      final outerMap = e as Map<String, dynamic>;
      final latLngMap = outerMap["location_id"] as Map<String, dynamic>;
      return const LatLngConverter().fromJson(latLngMap);
    }).toList();

    return list.lock;
  }

  @override
  List<dynamic> toJson(IList<LatLng> landmarks) {
    return landmarks
        .map((e) => {"location_id": const LatLngConverter().toJson(e)})
        .toList();
  }
}
