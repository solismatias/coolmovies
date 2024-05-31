class UtilDate {
  static String getYear(String? date) {
    if (date == null || date.isEmpty) return '';
    return date.split('-').first;
  }
}
