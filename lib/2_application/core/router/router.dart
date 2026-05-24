import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/core/router/go_router_observer.dart';
import 'package:todo_app/2_application/core/utils/breakpoints.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/cubit/navigation_todo_cubit.dart';
import 'package:todo_app/2_application/pages/home/home_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

const _basePath = '/home';

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '$_basePath/dashboard',

  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      name: SettingsPage.pageConfig.routeName,
      path: '$_basePath/settings',
      builder: (context, state) => SettingsPage(),
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: HomePage.pageConfig.routeName,
          path: '$_basePath/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab: state.pathParameters['tab'] ?? 'dashboard',
          ),
        ),
      ],
    ),

    GoRoute(
      path: '$_basePath/overview/:collectionId',
      name: TodoDetailPage.pageConfig.routeName,
      builder: (context, state) {
        final collectionId = CollectionId.fromUniqueString(
          state.pathParameters['collectionId'] ?? '',
        );
        return _DetailRouteHost(collectionId: collectionId);
      },
    ),
  ],
);

class _DetailRouteHost extends StatelessWidget {
  const _DetailRouteHost({required this.collectionId});
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    if (context.isWideScreen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        context.read<NavigationTodoCubit>().selectedToDoCollectionChanged(
          collectionId,
        );
        context.goNamed(
          HomePage.pageConfig.routeName,
          pathParameters: {'tab': OverviewPage.pageConfig.routeName},
        );
      });
      return const SizedBox.shrink();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.goNamed(
                HomePage.pageConfig.routeName,
                pathParameters: {'tab': OverviewPage.pageConfig.routeName},
              );
            }
          },
        ),
      ),
      body: ToDoDetailPageProvider(collectionId: collectionId),
    );
  }
}
