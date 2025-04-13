import "package:freezed_annotation/freezed_annotation.dart";

part "checkpoint.freezed.dart";
part "checkpoint.g.dart";

@freezed
abstract class Checkpoint with _$Checkpoint {
  const factory Checkpoint({
    required int id,
    required String name,
    required String description,
    required double longitude,
    required double latitude,
  }) = _Checkpoint;

  factory Checkpoint.fromJson(Map<String, dynamic> json) => _$CheckpointFromJson(json);
}
