import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../models/checkpoint.dart";

class LandmarkListConverter implements JsonConverter<IList<Checkpoint>, List<dynamic>> {
  const LandmarkListConverter();

  @override
  IList<Checkpoint> fromJson(List<dynamic> json) {
    final list =
        json
            .map((e) => Checkpoint.fromJson((e as Map<String, dynamic>)["landmarks_id"] as Map<String, dynamic>))
            .toList();
    return list.lock;
  }

  @override
  List<dynamic> toJson(IList<Checkpoint> landmarks) => landmarks.map((e) => {"landmarks_id": e.toJson()}).toList();
}
