import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/1_domain/use_cases/update_todo_entry.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_entry_state.dart';

class TodoEntryCubit extends Cubit<TodoEntryState> {
  TodoEntryCubit({
    required this.collectionId,
    required this.entryId,
    required this.loadTodoEntry,
    required this.updateToDoEntry,
  }) : super(TodoEntryLoadingState());

  final CollectionId collectionId;
  final EntryId entryId;
  final LoadTodoEntry loadTodoEntry;
  final UpdateTodoEntry updateToDoEntry;

  Future<void> fetch() async {
    emit(TodoEntryLoadingState());
    try {
      final toDoEntry = await loadTodoEntry.call(
        ToDoEntryIdParam(collectionId: collectionId, entryId: entryId),
      );

      toDoEntry.fold(
        (left) => emit(TodoEntryErrorState()),
        (right) => emit(TodoEntryLoadedState(toDoEntry: right)),
      );
    } on Exception {
      emit(TodoEntryErrorState());
    }
  }

  Future<void> update() async {
    try {
      final updatedEntry = await updateToDoEntry.call(
        ToDoEntryIdParam(collectionId: collectionId, entryId: entryId),
      );
      updatedEntry.fold(
        (left) => emit(TodoEntryErrorState()),
        (right) => emit(TodoEntryLoadedState(toDoEntry: right)),
      );
    } on Exception catch (e) {
      emit(TodoEntryErrorState());
    }
  }
}
