abstract final class DurationFormat {
  static String clock(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  static String short(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return minutes == 0 ? '$hours h' : '$hours h $minutes min';
    }
    if (minutes > 0) {
      return '$minutes min';
    }
    return '${duration.inSeconds} s';
  }
}
