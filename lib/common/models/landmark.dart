import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../app/l10n/arb/app_localizations.g.dart";
import "../parsers/latlng_converter.dart";

part "landmark.freezed.dart";
part "landmark.g.dart";

@freezed
abstract class Landmark with _$Landmark {
  const factory Landmark({
    required int id,
    required String name,
    required String description,
    required LandmarkType type,
    required DateTime? dateOfCreation,
    required String? designer,
    @LatLngConverter() required LatLng location,
  }) = _Landmark;

  factory Landmark.fromJson(Map<String, dynamic> json) => _$LandmarkFromJson(json);
}

enum LandmarkType { checkpoint, pulsometer }

extension LandmarkTypeX on LandmarkType {
  String toText(AppLocalizations l10n) {
    return switch (this) {
      LandmarkType.pulsometer => l10n.landmark_pulsometer_type,
      LandmarkType.checkpoint => l10n.landmark_checkpoint_type,
    };
  }
}
