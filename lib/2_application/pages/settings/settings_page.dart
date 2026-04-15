import 'package:flutter/material.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.settings_rounded,
    routeName: 'settings',
    child: SettingsPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.tealAccent);
  }
}
