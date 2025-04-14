import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

class LatLngConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(json["lat"] as double, json["lng"] as double);
  }

  @override
  Map<String, dynamic> toJson(LatLng object) {
    return {"lat": object.latitude, "lng": object.longitude};
  }
}
