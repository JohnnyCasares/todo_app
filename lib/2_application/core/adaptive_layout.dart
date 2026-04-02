import 'package:flutter/material.dart';
import 'package:todo_app/2_application/core/adaptive_pane_layout.dart';
import 'package:todo_app/2_application/core/navigation_widgets.dart';

class AdatptiveLayout extends StatefulWidget {
  final Widget pane1;
  final Widget pane2;
  const AdatptiveLayout({super.key, required this.pane1, required this.pane2});

  @override
  State<AdatptiveLayout> createState() => _AdatptiveLayoutState();
}

class _AdatptiveLayoutState extends State<AdatptiveLayout> {
  int selectedIndex = 0;

  bool wideScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    wideScreen = width > 600;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (wideScreen)
            DisappearingNavigationRail(
              selectedIndex: selectedIndex,
              backgroundColor: Colors.blue,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),

          Expanded(
            child: AdaptivePaneLayout(one: widget.pane1, two: widget.pane2),
          ),
        ],
      ),

      bottomNavigationBar: wideScreen
          ? null
          : DisappearingBottomNavigationBar(selectedIndex: selectedIndex),
    );
  }
}
