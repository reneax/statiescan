import 'package:flutter/material.dart';

class StoreHeader extends StatelessWidget {
  const StoreHeader({super.key, required this.title, required this.amount});

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: theme.textTheme.titleLarge),
          Text(amount, style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }
}
