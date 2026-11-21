part of 'create_todo_entry_cubit.dart';

class CreateTodoEntryState extends Equatable {
  final FormValue<String?>? description;

  const CreateTodoEntryState({this.description});

  CreateTodoEntryState copyWith({FormValue<String?>? description}) {
    return CreateTodoEntryState(description: description ?? this.description);
  }

  @override
  List<Object?> get props => [description];
}
