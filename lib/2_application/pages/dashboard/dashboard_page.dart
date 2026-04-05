import 'package:flutter/material.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';
import 'package:todo_app/2_application/core/widgets/adaptive_pane_layout.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.dashboard_rounded,
    routeName: 'dashboard',
    child: DashBoardPage(),
  );

  @override
  Widget build(BuildContext context) {
    return AdaptivePaneLayout(
      one: Container(color: Colors.purpleAccent),
      // two: Container(color: Colors.white),
    );
  }
}
