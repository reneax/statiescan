import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  static final List<String> routes = ['/'];

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  void _onItemTapped(BuildContext context, int index) {
    final String location = GoRouterState.of(context).matchedLocation;

    if (location == AppNavigationBar.routes[index]) {
      return;
    }

    context.go(AppNavigationBar.routes[index]);
  }

  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    final int index = AppNavigationBar.routes.indexOf(location);

    return index >= 0 ? index : 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: _getCurrentIndex(context),
      backgroundColor: theme.colorScheme.onInverseSurface,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.onSurface,
      onTap: (index) => _onItemTapped(context, index),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.question_mark), label: "Template"),
      ],
    );
  }
}