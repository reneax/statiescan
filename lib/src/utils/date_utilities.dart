import 'package:intl/intl.dart';

class DateUtilities {
  static String getExpiryText(DateTime? expiresAt, bool shortDate) {
    if (expiresAt == null) {
      return "Geen verloopdatum";
    }

    final formattedDate = (shortDate
            ? DateFormat.yMd('nl')
            : DateFormat.yMMMMd('nl'))
        .format(expiresAt);
    final isExpired = DateTime.now().isAfter(expiresAt);

    return "${isExpired ? 'Verlopen' : 'Verloopt'} op $formattedDate";
  }
}
