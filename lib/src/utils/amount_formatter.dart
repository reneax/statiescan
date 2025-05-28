class AmountFormatter {
  static String amountToString(int amountInCents) {
    return (amountInCents / 100).toStringAsFixed(2);
  }

  static int? stringToAmount(String amountString) {
    final cleaned = amountString.trim().replaceAll(',', '.');
    final parsed = double.tryParse(cleaned);

    if (parsed == null) return null;

    return (parsed * 100).round();
  }
}
