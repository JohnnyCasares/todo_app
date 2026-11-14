part of 'create_todo_colletion_page_cubit.dart';

class CreateTodoColletionPageState extends Equatable {
  final String? title;
  final String? color;

  const CreateTodoColletionPageState({this.title, this.color});

  CreateTodoColletionPageState copyWith({String? title, String? color}) {
    return CreateTodoColletionPageState(
      color: color ?? this.color,
      title: title ?? this.title,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [title, color];
}
