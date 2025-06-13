import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../parsers/landmark_list_converter.dart";
import "../parsers/latlng_list_converter.dart";
import "landmark.dart";
import "playlist.dart";

part "route.freezed.dart";
part "route.g.dart";

@freezed
abstract class Route with _$Route {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Route({
    required int id,
    required String name,
    required String description,
    required int? calories,
    required double distance,
    required double? waterDemand,
    required int estimatedTime,
    required Playlist playlist,
    @LatLngListConverter() required IList<LatLng> route,
    @LandmarkListConverter() required IList<Landmark> landmarks,
  }) = _Route;

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
}
