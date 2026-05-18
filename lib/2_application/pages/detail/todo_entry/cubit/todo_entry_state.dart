part of 'todo_entry_cubit.dart';

sealed class TodoEntryState extends Equatable {
  const TodoEntryState();

  @override
  List<Object> get props => [];
}

final class TodoEntryLoadingState extends TodoEntryState {
  const TodoEntryLoadingState();
}

final class TodoEntryLoadedState extends TodoEntryState {
  const TodoEntryLoadedState({required this.toDoEntry});
  final ToDoEntry toDoEntry;
  @override
  List<Object> get props => [toDoEntry];
}

final class TodoEntryErrorState extends TodoEntryState {
  const TodoEntryErrorState();
}
