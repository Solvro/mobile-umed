import "package:flutter/material.dart";
import "../../../../common/models/song.dart";

class SongTile extends StatelessWidget {
  const SongTile({super.key, required this.listIndex, required this.song});

  final int listIndex;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),

              child: Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                alignment: Alignment.center,
                child: Text(listIndex.toString()),
              ),
            ),
            Container(height: 20, width: 4, color: Colors.green),
            const SizedBox(height: 1),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [Text(song.name), Text(song.author)],
          ),
        ),
        Text(_durationToStr(song.duration)),
      ],
    );
  }
}

String _durationToStr(int duration) {
  final int minutes = duration ~/ 60;
  final int seconds = duration % 60;
  return "$minutes:$seconds";
}
