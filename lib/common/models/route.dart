import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "checkpoint.dart";
import "coords.dart";

part "route.freezed.dart";
part "route.g.dart";

@freezed
abstract class Route with _$Route {
  const factory Route({
    required int id,
    required String name,
    required String description,
    required int calories,
    required int length,
    required int requiredWater,
    required int estimatedTime,
    required Coords start,
    required Coords finish,
    required IList<Checkpoint> checkpoints,
  }) = _Route;

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
}
