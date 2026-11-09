/// Display formats for countdowns.
extension DurationFormatExtension on Duration {
  /// Formats as minutes and seconds, e.g. `14:05`.
  String toClockLabel() {
    final seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return '${inMinutes.toString().padLeft(2, '0')}:$seconds';
  }
}
