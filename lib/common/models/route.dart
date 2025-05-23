import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../parsers/landmark_list_converter.dart";
import "landmark.dart";

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
    required double? requiredWater,
    required int estimatedTime,
    @LandmarkListConverter() required IList<Landmark> landmarks,
  }) = _Route;

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
}

extension RouteParamsDoubleX on double {
  String inKilometers() {
    return "$this km";
  }

  String inMililiters() {
    return "${toInt()}\nml";
  }
}

extension RouteParamsIntX on int {
  String inMinutes() {
    return "$this\nmin";
  }

  String inKcal() {
    return "$this\nkcal";
  }
}
