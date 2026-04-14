import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';
import 'package:todo_app/2_application/core/widgets/navigation_widgets.dart';

class AdaptiveLayout extends StatefulWidget {
  final Widget child;
  const AdaptiveLayout({super.key, required this.child});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  final int animationDuration = 250;
  int selectedIndex = 0;
  bool wideScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final double width = MediaQuery.of(context).size.width;
    setState(() {
      wideScreen = width > 600;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 1. Side Navigation Animation
          AnimatedSize(
            duration: Duration(milliseconds: animationDuration),
            curve: Curves.easeInOut,
            child: SizedBox(
              width: wideScreen
                  ? null
                  : 0, // Collapses the width to 0 when not wide
              child: wideScreen
                  ? DisappearingNavigationRail(
                      key: const Key('primary-side-navigation'),
                      selectedIndex: selectedIndex,
                      backgroundColor: Colors.blue,
                      onDestinationSelected: _handleNavigation,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          Expanded(child: widget.child),
        ],
      ),
      // 2. Bottom Navigation Animation
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          // Slides the bottom bar up and down
          return SizeTransition(
            sizeFactor: animation,
            axisAlignment: -1.0,
            child: child,
          );
        },
        child: !wideScreen
            ? DisappearingBottomNavigationBar(
                key: const Key('bottom-navigation-small'),
                selectedIndex: selectedIndex,
                onDestinationSelected: _handleNavigation,
              )
            : const SizedBox.shrink(key: Key('bottom-none')),
      ),
    );
  }

  void _handleNavigation(int index) {
    setState(() {
      selectedIndex = index;
    });
    _tapOnNavigationDestination(context, selectedIndex);
  }
}

void _tapOnNavigationDestination(BuildContext context, int index) =>
    context.go('/home/${destinations[index].routeName}');
