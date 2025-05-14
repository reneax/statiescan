import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  static const List<({String location, NavigationDestination destination})>
  tabs = [
    (
      location: '/receipts',
      destination: NavigationDestination(
        icon: Icon(Icons.receipt_long),
        label: "Bonnen",
      ),
    ),
    (
      location: '/settings',
      destination: NavigationDestination(
        icon: Icon(Icons.settings),
        label: "Instellingen",
      ),
    ),
  ];

  int _locationToTabIndex(String location) {
    final index = tabs.indexWhere((tab) => tab.location == location);
    return index >= 0 ? index : 0;
  }

  void _navigateToIndex(
    BuildContext context,
    int index,
    String currentLocation,
  ) {
    final destination = tabs[index].location;
    if (destination != currentLocation) {
      context.go(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    final int currentIndex = _locationToTabIndex(location);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected:
          (index) => _navigateToIndex(context, index, location),
      destinations: tabs.map((tab) => tab.destination).toList(),
    );
  }
}
