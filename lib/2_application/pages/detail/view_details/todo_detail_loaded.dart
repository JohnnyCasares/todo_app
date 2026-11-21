import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo_app/2_application/pages/detail/bloc/todo_detail_cubit.dart';
import 'package:todo_app/2_application/pages/detail/todo_entry/todo_entry_page.dart';

class ToDoDetailLoaded extends StatelessWidget {
  const ToDoDetailLoaded({
    super.key,
    required this.entryIds,
    required this.collectionId,
  });

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: entryIds.length,
              itemBuilder: (context, index) {
                return ToDoEntryPageProvider(
                  collectionId: collectionId,
                  entryId: entryIds[index],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: 'create-todo-entry-fab',
                key: Key('create-todo-entry'),
                onPressed: () async {
                  final created = await context.pushNamed<bool>(
                    CreateToDoEntryPage.pageConfig.routeName,
                    extra: collectionId,
                  );
                  // Reload the list only if an entry was actually saved.
                  if (created == true && context.mounted) {
                    context.read<TodoDetailCubit>().fetch();
                  }
                },
                child: Icon(Icons.add_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
