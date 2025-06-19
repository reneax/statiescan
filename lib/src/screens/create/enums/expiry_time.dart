import 'package:flutter/cupertino.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

enum ExpiryTime {
  noExpiration(0),
  oneWeek(1),
  oneMonth(2),
  threeMonths(3),
  sixMonths(4),
  oneYear(5);

  final int id;

  const ExpiryTime(this.id);

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

  String getLabel(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return switch (this) {
      ExpiryTime.noExpiration => loc.noExpiration,
      ExpiryTime.oneWeek => loc.oneWeek,
      ExpiryTime.oneMonth => loc.oneMonth,
      ExpiryTime.threeMonths => loc.threeMonths,
      ExpiryTime.sixMonths => loc.sixMonths,
      ExpiryTime.oneYear => loc.oneYear,
    };
  }
}
