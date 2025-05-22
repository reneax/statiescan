enum ExpiryTime {
  noExpiration(0, 'Geen', null),
  oneWeek(1, '1 week', Duration(days: 7)),
  oneMonth(2, '1 maand', Duration(days: 30)),
  threeMonths(3, '3 maanden', Duration(days: 90)),
  sixMonths(4, '6 maanden', Duration(days: 180)),
  oneYear(5, '1 jaar', Duration(days: 365));

  final int id;
  final String label;
  final Duration? duration;

  const ExpiryTime(this.id, this.label, this.duration);
}
