import 'package:flutter/material.dart';

extension BreakpointUtils on BuildContext {
  // Returns true if screen is wider than 600px
  bool get isWideScreen => MediaQuery.of(this).size.width > 600;

  // You can add more specific ones later
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 600 &&
      MediaQuery.of(this).size.width < 1200;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1200;
}
