import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../models/song.dart";

class SongsListConverter implements JsonConverter<IList<Song>, List<dynamic>> {
  const SongsListConverter();

  @override
  IList<Song> fromJson(List<dynamic> json) {
    final list = json
        .map((e) => Song.fromJson(
            (e as Map<String, dynamic>)["songs_id"] as Map<String, dynamic>))
        .toList();
    return list.lock;
  }

  @override
  List<dynamic> toJson(IList<Song> landmarks) =>
      landmarks.map((e) => {"songs_id": e.toJson()}).toList();
}
