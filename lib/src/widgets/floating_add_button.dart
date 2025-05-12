import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  const FloatingAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {},
    );
  }
}
