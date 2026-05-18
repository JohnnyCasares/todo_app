import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/1_domain/use_cases/update_todo_entry.dart';
import 'package:todo_app/2_application/pages/detail/todo_entry/cubit/todo_entry_cubit.dart';
import 'package:todo_app/2_application/pages/detail/todo_entry/view_states/todo_entry_error.dart';
import 'package:todo_app/2_application/pages/detail/todo_entry/view_states/todo_entry_loaded.dart';
import 'package:todo_app/2_application/pages/detail/todo_entry/view_states/todo_entry_loading.dart';

class ToDoEntryPageProvider extends StatelessWidget {
  const ToDoEntryPageProvider({
    super.key,
    required this.collectionId,
    required this.entryId,
  });
  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoEntryCubit>(
      create: (context) => TodoEntryCubit(
        collectionId: collectionId,
        entryId: entryId,
        loadTodoEntry: LoadTodoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
        updateToDoEntry: UpdateTodoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      )..fetch(),
      child: TodoEntryPage(entryId: entryId),
    );
  }
}

class TodoEntryPage extends StatelessWidget {
  const TodoEntryPage({super.key, required this.entryId});

  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEntryCubit, TodoEntryState>(
      builder: (context, state) {
        if (state is TodoEntryLoadingState) {
          return ToDoEntryLoading();
        } else if (state is TodoEntryLoadedState) {
          return ToDoEntryLoaded(
            todoEntry: state.toDoEntry,
            onChanged: (value) => context.read<TodoEntryCubit>().update(),
          );
        } else {
          return ToDoEntryError();
        }
      },
    );
  }
}
