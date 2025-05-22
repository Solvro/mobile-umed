import "package:flutter/material.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../../../app/theme/app_theme.dart";
import "../../../../../common/models/song.dart";
import "../../../../../common/widgets/list_label.dart";

class SongItem extends StatelessWidget {
  const SongItem({super.key, required this.listIndex, required this.song});

  final int listIndex;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: PlaylistInfoConfig.songTileSpacing,
      children: [
        ListLabel(index: listIndex),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [Text(song.name, style: context.textTheme.headlineSmall), Text(song.author)],
          ),
        ),
        Text(song.duration.toShortTimeString()),
      ],
    );
  }
}

extension DurationFormatting on Duration {
  String toShortTimeString() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
