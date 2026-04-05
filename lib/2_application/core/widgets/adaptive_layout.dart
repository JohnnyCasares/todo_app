import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';
import 'package:todo_app/2_application/core/widgets/navigation_widgets.dart';
import 'package:todo_app/2_application/pages/home/home_page.dart';

class AdaptiveLayout extends StatefulWidget {
  final Widget child;
  const AdaptiveLayout({super.key, required this.child});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  int selectedIndex = 0;
  bool wideScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    wideScreen = width > 600;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (wideScreen)
            DisappearingNavigationRail(
              key: Key('primary-side-navigation'),
              selectedIndex: selectedIndex,
              backgroundColor: Colors.blue,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
                _tapOnNavigationDestination(context, selectedIndex);
              },
            ),

          Expanded(child: widget.child),
        ],
      ),

      bottomNavigationBar: wideScreen
          ? null
          : DisappearingBottomNavigationBar(
              key: Key('bottom-navigation-small'),
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
                _tapOnNavigationDestination(context, selectedIndex);
              },
            ),
    );
  }
}

void _tapOnNavigationDestination(BuildContext context, int index) =>
    context.go('/home/${destinations[index].routeName}');
