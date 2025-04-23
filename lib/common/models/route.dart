import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../parsers/landmark_list_converter.dart";
import "landmark.dart";

part "route.freezed.dart";
part "route.g.dart";

@freezed
abstract class Route with _$Route {
  const factory Route({
    required int id,
    required String name,
    required String description,
    @Default(0) int calories,
    @JsonKey(name: "distance") required double length,
    @Default(0.0) double requiredWater,
    @JsonKey(name: "estimated_time") required int estimatedTime,
    @LandmarkListConverter() required IList<Landmark> landmarks,
  }) = _Route;

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
}
