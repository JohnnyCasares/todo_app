import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  redirect: (context, state) {
    // If the user lands on /home, send them to /home/start automatically
    if (state.uri.path == '/home') return '/home/start';
    return null;
  },

  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      path: '/home/settings',
      builder: (context, state) {
        return Container(
          color: Colors.amber,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => context.push('/home/start'),
                child: Text('Go to start'),
              ),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.push('/home/start');
                  }
                },
                child: Text('Go back'),
              ),
            ],
          ),
        );
      },
    ),
    GoRoute(
      path: '/home/start',
      builder: (context, state) {
        return Container(
          color: Colors.blueGrey,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => context.push('/home/settings'),
                child: Text('Go to settings'),
              ),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.push('/home/settings');
                  }
                },
                child: Text('Go back'),
              ),
            ],
          ),
        );
      },
    ),

    GoRoute(
      path: '/home/new',
      builder: (context, state) {
        return Container(
          color: Colors.lightGreenAccent,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text('Go back'),
              ),
            ],
          ),
        );
      },
    ),
  ],
);
