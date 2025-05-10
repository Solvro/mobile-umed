import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../../common/models/song.dart";
import "../../../../common/widgets/music_service_button.dart";
import "song_tile.dart";

class PlaylistInfoSection extends StatefulWidget {
  const PlaylistInfoSection({super.key, required this.songs});

  final IList<Song> songs;

  @override
  State<StatefulWidget> createState() => _PlaylistInfoSectionState();
}

class _PlaylistInfoSectionState extends State<PlaylistInfoSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 5,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MusicServiceButton(
                icon: Icons.queue_music,
                onPressed: () {
                  debugPrint("tu bedzie link do spotify");
                },
              ),
              MusicServiceButton(
                icon: Icons.play_circle_fill,
                onPressed: () {
                  debugPrint("tu bedzie link do yt music");
                },
              ),
              MusicServiceButton(
                icon: Icons.apple,
                onPressed: () {
                  debugPrint("tu bedzie link do apple music");
                },
              ),
            ],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: widget.songs.length,
            itemBuilder: (context, index) {
              final song = widget.songs[index];
              return SongTile(listIndex: index + 1, song: song);
            },
          ),
        ],
      ),
    );
  }
}
