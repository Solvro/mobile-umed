import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../../common/models/song.dart";
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
              Container(
                decoration: _decoration(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.queue_music),
              ),
              Container(
                decoration: _decoration(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.play_circle_fill),
              ),
              Container(
                decoration: _decoration(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.apple),
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

BoxDecoration _decoration() {
  return BoxDecoration(
    border: Border.all(color: Colors.green, width: 2),
    borderRadius: const BorderRadius.all(Radius.circular(12)),
  );
}
