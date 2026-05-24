import 'package:flutter/material.dart';

class AdaptivePaneLayout extends StatelessWidget {
  const AdaptivePaneLayout({
    super.key,
    required this.mainScreen,
    this.secondaryScreen,
  });

  final Widget mainScreen;
  final Widget? secondaryScreen;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isWideScreen = width >= 600 && secondaryScreen != null;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        // This adds a smooth fade and slight scale/slide to the transition
        return FadeTransition(opacity: animation, child: child);
      },
      child: isWideScreen
          ? Row(
              key: const ValueKey('wide-layout'),
              children: [
                Expanded(flex: 1000, child: mainScreen),
                Expanded(
                  // We use the dynamic flex here
                  flex: _getDetailFlex(width),
                  child: secondaryScreen!,
                ),
              ],
            )
          : SizedBox.expand(
              key: const ValueKey('narrow-layout'),
              child: mainScreen,
            ),
    );
  }

  int _getDetailFlex(double width) {
    return switch (width) {
      >= 800 && < 1200 => 1500,
      >= 1200 && < 1600 => 2000,
      >= 1600 => 3000,
      _ => 1000,
    };
  }
}
