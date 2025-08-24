import "package:freezed_annotation/freezed_annotation.dart";

import "../parsers/duration_converter.dart";

part "song.freezed.dart";
part "song.g.dart";

@freezed
abstract class Song with _$Song {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Song({
    required int id,
    required String title,
    required String author,
    @DurationMinutesConverter() required Duration duration,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}
