part of 'todo_overview_cubit.dart';

sealed class ToDoOverviewCubitState extends Equatable {
  const ToDoOverviewCubitState();

  @override
  List<Object> get props => [];
}

final class TodoOverviewCubitLoadingState extends ToDoOverviewCubitState {}

final class TodoOverviewCubitErrorState extends ToDoOverviewCubitState {}

final class TodoOverviewCubitLoadedState extends ToDoOverviewCubitState {
  const TodoOverviewCubitLoadedState({required this.collections});
  final List<ToDoCollection> collections;
  @override
  List<Object> get props => [collections];
}
