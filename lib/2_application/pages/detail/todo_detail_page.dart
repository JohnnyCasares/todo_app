import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/2_application/core/navigation/destinations.dart';
import 'package:todo_app/2_application/pages/detail/bloc/todo_detail_cubit.dart';
import 'package:todo_app/2_application/pages/detail/view_details/todo_detail_error.dart';
import 'package:todo_app/2_application/pages/detail/view_details/todo_detail_loaded.dart';
import 'package:todo_app/2_application/pages/detail/view_details/todo_detail_loading.dart';

class ToDoDetailPageProvider extends StatelessWidget {
  const ToDoDetailPageProvider({super.key, required this.collectionId});

  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoDetailCubit>(
      create: (context) => TodoDetailCubit(
        collectionId: collectionId,
        loadTodoEntryIdsForCollection: LoadTodoEntryIdsForCollection(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      )..fetch(),
      child: TodoDetailPage(collectionId: collectionId),
    );
  }
}

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({super.key, required this.collectionId});
  final CollectionId collectionId;

  static const pageConfig = PageConfig(
    icon: Icons.details_rounded,
    routeName: 'detail',
    child: Placeholder(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoDetailCubit, ToDoDetailCubitState>(
      builder: (context, state) {
        if (state is ToDoDetaiCubitLoadingState) {
          return ToDoDetailLoading();
        } else if (state is ToDoDetaiCubitLoadedState) {
          return ToDoDetailLoaded(
            entryIds: state.entryIds,
            collectionId: collectionId,
          );
        } else {
          return ToDoDetailError();
        }
      },
    );
  }
}
