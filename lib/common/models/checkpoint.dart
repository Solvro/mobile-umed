import "package:freezed_annotation/freezed_annotation.dart";

import "coords.dart";

part "checkpoint.freezed.dart";
part "checkpoint.g.dart";

@freezed
abstract class Checkpoint with _$Checkpoint {
  const factory Checkpoint({
    required int id,
    required String name,
    required String description,
    required Coords coords,
  }) = _Checkpoint;

  factory Checkpoint.fromJson(Map<String, dynamic> json) => _$CheckpointFromJson(json);
}
