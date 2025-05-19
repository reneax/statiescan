import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FloatingAddButton extends StatelessWidget {
  const FloatingAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.push("/scan"),
      child: const Icon(Icons.add),
    );
  }
}
