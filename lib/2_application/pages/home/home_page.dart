import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';
import 'package:todo_app/2_application/core/utils/breakpoints.dart';
import 'package:todo_app/2_application/core/widgets/adaptive_layout.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required String tab})
    : index = destinations.indexWhere((element) => element.routeName == tab);

  static const pageConfig = PageConfig(
    icon: Icons.home_rounded,
    routeName: 'home',
  );

  final int index;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bool wideScreen = context.isWideScreen;
    return Scaffold(
      appBar: wideScreen
          ? null
          : AppBar(
              actions: [
                IconButton(
                  onPressed: () =>
                      context.goNamed(SettingsPage.pageConfig.routeName),
                  icon: Icon(SettingsPage.pageConfig.icon),
                ),
              ],
            ),
      body: SafeArea(
        child: AdaptiveLayout(
          onNavigationSelected: _tapOnNavigationDestination,
          child: destinations[widget.index].child,
        ),
      ),
    );
  }
}

void _tapOnNavigationDestination(BuildContext context, int index) =>
    context.goNamed(
      HomePage.pageConfig.routeName,
      pathParameters: {'tab': destinations[index].routeName},
    );
