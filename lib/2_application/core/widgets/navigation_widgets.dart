import 'package:flutter/material.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';

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
    // final colorScheme = Theme.of(context).colorScheme;
    return NavigationRail(
      selectedIndex: selectedIndex,
      backgroundColor: backgroundColor,
      onDestinationSelected: onDestinationSelected,
      // leading: Column(
      //   children: [
      //     IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      //     const SizedBox(height: 8),
      //     FloatingActionButton(
      //       shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(15)),
      //       ),
      //       backgroundColor: colorScheme.tertiaryContainer,
      //       foregroundColor: colorScheme.onTertiaryContainer,
      //       onPressed: () {},
      //       child: const Icon(Icons.add),
      //     ),
      //   ],
      // ),
      groupAlignment: -0.85,
      destinations: destinations.map<NavigationRailDestination>((d) {
        return NavigationRailDestination(
          icon: Icon(d.icon),
          label: Text(d.routeName),
        );
      }).toList(),
    );
  }
}
