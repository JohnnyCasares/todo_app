import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/2_application/core/utils/breakpoints.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/cubit/navigation_todo_cubit.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/2_application/pages/overview/bloc/cubit/todo_overview_cubit.dart';

class ToDoOverviewLoaded extends StatelessWidget {
  const ToDoOverviewLoaded({super.key, required this.collections});

  final List<ToDoCollection> collections;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        ListView.builder(
          itemCount: collections.length,
          itemBuilder: (context, index) {
            final item = collections[index];

            return BlocBuilder<NavigationTodoCubit, NavigationTodoCubitState>(
              buildWhen: (previous, current) =>
                  previous.selectedCollectionId != current.selectedCollectionId,
              builder: (context, state) {
                return ListTile(
                  tileColor: colorScheme.surface,
                  selectedTileColor: colorScheme.onSurfaceVariant,
                  iconColor: item.color.color,
                  selectedColor: item.color.color,
                  selected: state.selectedCollectionId == item.id,
                  onTap: () {
                    context
                        .read<NavigationTodoCubit>()
                        .selectedToDoCollectionChanged(item.id);

                    if (!context.isWideScreen) {
                      debugPrint(item.id.value);
                      context.goNamed(
                        TodoDetailPage.pageConfig.routeName,
                        pathParameters: {'collectionId': item.id.value},
                      );
                    }
                  },
                  leading: const Icon(Icons.circle),
                  title: Text(item.title),
                );
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: 'create-todo-collection-fab',
              key: Key('create-todo-collection'),
              onPressed: () async {
                final created = await context.pushNamed<bool>(
                  CreateToDoCollectionPage.pageConfig.routeName,
                );

                if (created == true && context.mounted) {
                  context.read<ToDoOverviewCubit>().readToDoCollections();
                }
              },
              child: Icon(CreateToDoCollectionPage.pageConfig.icon),
            ),
          ),
        ),
      ],
    );
  }
}
