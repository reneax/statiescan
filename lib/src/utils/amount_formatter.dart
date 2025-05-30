class AmountFormatter {
  static String amountToString(int amountInCents) {
    return (amountInCents / 100).toStringAsFixed(2);
  }

  static int? stringToAmount(String amountString) {
    try {
      final cleaned = amountString.trim().replaceAll(',', '.');
      final parsed = double.parse(cleaned);

      return (parsed * 100).round();
    } catch (ex) {
      return null;
    }
  }
}
