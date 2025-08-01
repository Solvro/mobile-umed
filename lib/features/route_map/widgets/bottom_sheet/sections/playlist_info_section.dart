import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../../../common/models/song.dart";
import "../../../../../common/widgets/buttons/secondary_action_button.dart";
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
    return Container(
      padding: const EdgeInsets.all(PlaylistInfoConfig.contentPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: PlaylistInfoConfig.verticalSpacing,
        children: [
          Row(
            spacing: PlaylistInfoConfig.horizontalButtonSpacing,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SecondaryActionButton(
                  // TODO(simplyNoOne): zmienic ta ikonke
                  iconData: Icons.queue_music,
                  onPressed: () {
                    // TODO(simplyNoOne): tu bedzie link do spotify
                  },
                ),
              ),
              Expanded(
                child: SecondaryActionButton(
                  iconData: Icons.play_circle_fill,
                  onPressed: () {
                    // TODO(simplyNoOne): tu bedzie link do yt music
                  },
                ),
              ),
              Expanded(
                child: SecondaryActionButton(
                  iconData: Icons.apple,
                  onPressed: () {
                    // TODO(simplyNoOne): tu bedzie link do apple music
                  },
                ),
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
