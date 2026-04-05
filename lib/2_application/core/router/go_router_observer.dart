import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  GoRouterObserver();

  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    debugPrint('didChangeTop: ${topRoute.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('didPop: ${route.settings.name}');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      'didPush: ${route.settings.name} previousRoute: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      'didRemove: ${route.settings.name} previousRoute: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint(
      'didReplace: ${newRoute?.settings.name} previousRoute: ${oldRoute?.settings.name}',
    );
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    debugPrint(
      'didRemove: ${route.settings.name} previousRoute: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didStopUserGesture() {
    debugPrint('didStopUserGesture');
  }
}
