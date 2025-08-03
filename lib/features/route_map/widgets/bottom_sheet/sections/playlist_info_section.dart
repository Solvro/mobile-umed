import "package:flutter/material.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../../../common/models/playlist.dart";
import "../../../../../common/utils/url_launcher.dart";
import "../../../../../common/widgets/buttons/secondary_action_button.dart";
import "song_tile.dart";

class PlaylistInfoSection extends StatefulWidget {
  const PlaylistInfoSection({super.key, required this.playlist});

  final Playlist playlist;

  @override
  State<StatefulWidget> createState() => _PlaylistInfoSectionState();
}

class _PlaylistInfoSectionState extends State<PlaylistInfoSection> {
  @override
  Widget build(BuildContext context) {
    final playlist = widget.playlist;
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
                  onPressed: () async => customLaunchUrl(playlist.spotifyUrl),
                ),
              ),
              if (playlist.youtubeUrl != null)
                Expanded(
                  child: SecondaryActionButton(
                    iconData: Icons.play_circle_fill,
                    onPressed: () async => customLaunchUrl(playlist.youtubeUrl!),
                  ),
                ),
              if (playlist.appleUrl != null)
                Expanded(
                  child: SecondaryActionButton(
                    iconData: Icons.apple,
                    onPressed: () async => customLaunchUrl(playlist.appleUrl!),
                  ),
                ),
            ],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: playlist.songs.length,
            itemBuilder: (context, index) {
              final song = widget.playlist.songs[index];
              return SongTile(listIndex: index + 1, song: song);
            },
          ),
        ],
      ),
    );
  }
}
