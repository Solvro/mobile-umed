extension DurationFormatting on Duration {
  String toHmsString() {
    final hours = inHours;
    final minutes = inMinutes % 60;
    final seconds = inSeconds % 60;
    return "${hours.toString().padLeft(2, '0')}:"
        "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
  }

  String toShortTimeString() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
