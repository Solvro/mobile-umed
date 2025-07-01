import "package:flutter/material.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../../../app/theme/app_theme.dart";
import "../../../../../common/models/song.dart";

class SongTile extends StatelessWidget {
  const SongTile({super.key, required this.listIndex, required this.song});

  final int listIndex;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: PlaylistInfoConfig.songTileSpacing,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppPaddings.nano,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),

              child: Container(
                height: PlaylistInfoConfig.songTileDotRad,
                width: PlaylistInfoConfig.songTileDotRad,
                decoration: BoxDecoration(shape: BoxShape.circle, color: context.colorScheme.primary),
                alignment: Alignment.center,
                child: Text(listIndex.toString(), style: TextStyle(color: context.colorScheme.onPrimary)),
              ),
            ),
            Container(height: PlaylistInfoConfig.songTileDotRad, width: 4, color: context.colorScheme.primary),
            const SizedBox(height: 1),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [Text(song.title), Text(song.author)],
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
