import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../models/landmark.dart";

class LandmarkListConverter implements JsonConverter<IList<Landmark>, List<dynamic>> {
  const LandmarkListConverter();

  @override
  IList<Landmark> fromJson(List<dynamic> json) {
    final list =
        json
            .map((e) => Landmark.fromJson((e as Map<String, dynamic>)["landmarks_id"] as Map<String, dynamic>))
            .toList();
    return list.lock;
  }

  @override
  List<dynamic> toJson(IList<Landmark> landmarks) => landmarks.map((e) => {"landmarks_id": e.toJson()}).toList();
}
