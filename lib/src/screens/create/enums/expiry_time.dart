enum ExpiryTime {
  noExpiration(0, 'Geen', null),
  oneWeek(1, '1 week', 7),
  oneMonth(2, '1 maand', 31),
  threeMonths(3, '3 maanden', 90),
  sixMonths(4, '6 maanden', 180),
  oneYear(5, '1 jaar', 365);

  final int id;
  final String label;
  final int? days;

  const ExpiryTime(this.id, this.label, this.days);
}
