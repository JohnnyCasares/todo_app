import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collections.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';
import 'package:todo_app/2_application/core/widgets/adaptive_pane_layout.dart';
import 'package:todo_app/2_application/pages/overview/bloc/cubit/todo_overview_cubit.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_error.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_loaded.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_loading.dart';

class OverviewPageProvider extends StatelessWidget {
  const OverviewPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoOverviewCubit(
        loadToDoCollections: LoadToDoCollections(
          toDoRepository: RepositoryProvider.of(context),
        ),
      )..readToDoCollections(),
      child: const OveriewPage(),
    );
  }
}

class OveriewPage extends StatelessWidget {
  const OveriewPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.work_history_rounded,
    routeName: 'overview',
    child: OverviewPageProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return AdaptivePaneLayout(
      one: Container(
        color: Colors.yellow,
        child: BlocBuilder<ToDoOverviewCubit, ToDoOverviewCubitState>(
          builder: (context, state) {
            if (state is TodoOverviewCubitLoadingState) {
              return const ToDoOverviewLoading();
            } else if (state is TodoOverviewCubitLoadedState) {
              return ToDoOverviewLoaded(collections: state.collections);
            } else {
              return const ToDoOverviewError();
            }
          },
        ),
      ),
      two: Container(color: Colors.blue),
    );
  }
}
