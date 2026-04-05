import 'package:flutter/material.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';
import 'package:todo_app/2_application/core/widgets/adaptive_pane_layout.dart';

class OveriewPage extends StatelessWidget {
  const OveriewPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.work_history_rounded,
    routeName: 'overview',
    child: OveriewPage(),
  );

  @override
  Widget build(BuildContext context) {
    return AdaptivePaneLayout(
      one: Container(color: Colors.yellow),
      two: Container(color: Colors.blue),
    );
  }
}
