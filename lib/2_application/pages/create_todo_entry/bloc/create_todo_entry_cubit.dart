import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/2_application/core/utils/form_value.dart';
import 'package:todo_app/core/use_case.dart';
part 'create_todo_entry_state.dart';

class CreateTodoEntryCubit extends Cubit<CreateTodoEntryState> {
  CreateTodoEntryCubit({required this.collectionId, required this.addToDoEntry})
    : super(CreateTodoEntryState());

  final CollectionId collectionId;
  final CreateToDoEntry addToDoEntry;

  void descriptionChanged({required String? description}) {
    ValidationStatus currentStatus = ValidationStatus.pending;
    if (description == null || description.isEmpty || description.length < 2) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.success;
    }
    emit(
      state.copyWith(
        description: FormValue(
          value: description,
          validationStatus: currentStatus,
        ),
      ),
    );
  }

  /// Saves the entry. Returns true on success, false on failure, so the page
  /// can decide whether to pop or show an error.
  Future<bool> submit() async {
    final result = await addToDoEntry.call(
      ToDoEntryParams(
        collectionId: collectionId,
        entry: ToDoEntry(
          description: state.description?.value ?? '',
          isDone: false,
          id: EntryId(),
        ),
      ),
    );
    return result.isRight;
  }
}
