import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../parsers/songs_list_converter.dart";
import "song.dart";

part "playlist.freezed.dart";
part "playlist.g.dart";

@freezed
abstract class Playlist with _$Playlist {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Playlist({
    required int id,
    required String name,
    required String spotifyUrl,
    required String youtubeUrl,
    required String appleUrl,
    @SongsListConverter() required IList<Song> songs,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);
}
