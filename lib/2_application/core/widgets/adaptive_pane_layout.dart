import 'package:flutter/material.dart';

class AdaptivePaneLayout extends StatelessWidget {
  const AdaptivePaneLayout({super.key, required this.one, this.two});

  final Widget one;
  final Widget? two;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    // We only show the second pane if the screen is wide enough (e.g., > 600)
    final bool isWideScreen = width >= 600;

    if (!isWideScreen) {
      return one; // Mobile view: just show the list
    }

    // Determine the flex ratio based on width (mirroring your switch logic)
    int detailFlex = switch (width) {
      >= 800 && < 1200 => 1500,
      >= 1200 && < 1600 => 2000,
      >= 1600 => 3000,
      _ => 1000,
    };

    return Row(
      children: [
        Expanded(key: Key('primary-body'), flex: 1000, child: one),
        if (two != null)
          Expanded(key: Key('secondary-body'), flex: detailFlex, child: two!),
      ],
    );
  }
}
