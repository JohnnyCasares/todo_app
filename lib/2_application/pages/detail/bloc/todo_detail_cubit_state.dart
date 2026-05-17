part of 'todo_detail_cubit.dart';

abstract class ToDoDetailCubitState extends Equatable {
  const ToDoDetailCubitState();

  @override
  List<Object?> get props => [];
}

class ToDoDetaiCubitLoadingState extends ToDoDetailCubitState {
  const ToDoDetaiCubitLoadingState();
}

class ToDoDetaiCubitErrorState extends ToDoDetailCubitState {
  const ToDoDetaiCubitErrorState();
}

class ToDoDetaiCubitLoadedState extends ToDoDetailCubitState {
  const ToDoDetaiCubitLoadedState({required this.entryIds});
  final List<EntryId> entryIds;
  @override
  List<Object?> get props => [entryIds];
}
