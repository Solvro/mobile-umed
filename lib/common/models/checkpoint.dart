import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../app/l10n/arb/app_localizations.g.dart";
import "../parsers/latlng_converter.dart";

part "checkpoint.freezed.dart";
part "checkpoint.g.dart";

@freezed
abstract class Checkpoint with _$Checkpoint {
  const factory Checkpoint({
    required int id,
    required String name,
    required String? description,
    required LandmarkType type,
    required DateTime? dateOfCreation,
    required String? designer,
    @LatLngConverter() required LatLng location,
  }) = _Checkpoint;

  factory Checkpoint.fromJson(Map<String, dynamic> json) => _$CheckpointFromJson(json);
}

enum LandmarkType { start, checkpoint, pulsometer, finish }

extension LandmarkTypeX on LandmarkType {
  String toText(AppLocalizations l10n) {
    return switch (this) {
      LandmarkType.start => l10n.landmark_start_type,
      LandmarkType.pulsometer => l10n.landmark_pulsometer_type,
      LandmarkType.checkpoint => l10n.landmark_checkpoint_type,
      LandmarkType.finish => l10n.landmark_finish_type,
    };
  }
}
