import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_todo_colletion_page_state.dart';

class CreateToDoCollectionPageCubit
    extends Cubit<CreateTodoColletionPageState> {
  CreateToDoCollectionPageCubit() : super(const CreateTodoColletionPageState());

  void titleChange(String title) {
    emit(state.copyWith(title: title));
  }

  void colorChange(String color) {
    emit(state.copyWith(color: color));
  }

  Future<void> submit() async {
    //todo implement
  }
}
