extension DateTimeExtension on DateTime {
  int get dayOfYear {
    int dayCount = 0;
    for (int i = 1; i < month; i++) {
      dayCount += DateTime(year, i + 1, 0).day;
    }
    return dayCount + day;
  }
}
