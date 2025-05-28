import 'package:intl/intl.dart';

class DateUtilities {
  static String getExpiryText(DateTime? expiresAt) {
    if (expiresAt == null) {
      return "Geen verloopdatum";
    }

    final formattedDate = DateFormat.yMMMMd('nl').format(expiresAt);
    final isExpired = DateTime.now().isAfter(expiresAt);

    return "${isExpired ? 'Verlopen' : 'Verloopt'} op $formattedDate";
  }
}
