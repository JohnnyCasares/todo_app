import 'package:flutter/material.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';

class PageConfig {
  const PageConfig({required this.icon, required this.routeName, Widget? child})
    : child = child ?? const Placeholder();

  final IconData icon;
  final String routeName;
  final Widget child;
}

const List<PageConfig> destinations = <PageConfig>[
  DashBoardPage.pageConfig,
  OveriewPage.pageConfig,
];
