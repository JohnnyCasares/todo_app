import 'package:flutter/material.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';
import 'package:todo_app/2_application/core/widgets/adaptive_layout.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required String tab})
    : index = destinations.indexWhere((element) => element.routeName == tab);

  final int index;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(child: destinations[widget.index].child),
      ),
    );
  }
}
