import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

///DisappearingBottomNavigationBar is used for mobile and smal vertical content
class DisappearingBottomNavigationBar extends StatelessWidget {
  const DisappearingBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 0,
      backgroundColor: Colors.white,
      destinations: destinations.map<NavigationDestination>((d) {
        return NavigationDestination(icon: Icon(d.icon), label: d.routeName);
      }).toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}

/// DisappearingNavigationRail is used when the app is in a big display or horizontal...
class DisappearingNavigationRail extends StatelessWidget {
  const DisappearingNavigationRail({
    super.key,
    required this.backgroundColor,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final Color backgroundColor;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      backgroundColor: backgroundColor,
      onDestinationSelected: onDestinationSelected,
      groupAlignment: -0.85,
      destinations: destinations.map<NavigationRailDestination>((d) {
        return NavigationRailDestination(
          icon: Icon(d.icon),
          label: Text(d.routeName),
        );
      }).toList(),
      trailingAtBottom: true,
      trailing: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: IconButton(
          onPressed: () => context.goNamed(SettingsPage.pageConfig.routeName),
          icon: Icon(SettingsPage.pageConfig.icon),
        ),
      ),
    );
  }
}
