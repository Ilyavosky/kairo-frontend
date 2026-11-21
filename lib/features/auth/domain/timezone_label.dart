abstract final class TimezoneLabel {
  static String city(String timezone) {
    final city = timezone.split('/').last.replaceAll('_', ' ');
    return city.isEmpty ? timezone : city;
  }

  static bool matches(String timezone, String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return true;
    }
    return timezone.toLowerCase().replaceAll('_', ' ').contains(normalized);
  }
}
