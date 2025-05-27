enum ExpiryTime {
  noExpiration(0, 'Geen'),
  oneWeek(1, '1 week'),
  oneMonth(2, '1 maand'),
  threeMonths(3, '3 maanden'),
  sixMonths(4, '6 maanden'),
  oneYear(5, '1 jaar');

  final int id;
  final String label;

  const ExpiryTime(this.id, this.label);

  DateTime? getExpiryDate(DateTime from) {
    switch (this) {
      case ExpiryTime.noExpiration:
        return null;
      case ExpiryTime.oneWeek:
        return from.add(Duration(days: 7));
      case ExpiryTime.oneMonth:
        return DateTime(from.year, from.month + 1, from.day);
      case ExpiryTime.threeMonths:
        return DateTime(from.year, from.month + 3, from.day);
      case ExpiryTime.sixMonths:
        return DateTime(from.year, from.month + 6, from.day);
      case ExpiryTime.oneYear:
        return DateTime(from.year + 1, from.month, from.day);
    }
  }
}
