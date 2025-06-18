import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  List<({String location, NavigationDestination destination})> get tabs {
    return [
      (
        location: '/receipts',
        destination: NavigationDestination(
          icon: Icon(Icons.receipt_long),
          label: AppLocalizations.of(context)!.receiptsTab,
        ),
      ),
      (
        location: '/settings',
        destination: NavigationDestination(
          icon: Icon(Icons.settings),
          label: AppLocalizations.of(context)!.settingsTab,
        ),
      ),
    ];
  }

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
    context.go(destination);
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
