import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../app/l10n/l10n.dart";
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
  String toText(BuildContext context) {
    return this == LandmarkType.checkpoint ? context.l10n.checkpoint_type : context.l10n.pulsometer_type;
  }
}
