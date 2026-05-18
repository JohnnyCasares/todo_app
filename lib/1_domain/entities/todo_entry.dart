import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

class ToDoEntry extends Equatable {
  final String description;
  final bool isDone;
  final EntryId id;

  const ToDoEntry({
    required this.description,
    required this.isDone,
    required this.id,
  });

  factory ToDoEntry.empty() {
    return ToDoEntry(description: '', isDone: false, id: EntryId());
  }

  ToDoEntry copyWith({String? description, bool? isDone}) {
    return ToDoEntry(
      id: id,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id, description, isDone];
  // ==========================================
  // THE "WHY" BEHIND EQUATABLE PROPS:
  // ==========================================
  // By placing 'id', 'description', and 'isDone' inside the props list,
  // we tell Equatable exactly which fields to inspect when comparing two instances.
  //
  // If props is left empty ([]), Equatable thinks every ToDoEntry instance is identical.
  // When a checkbox flips, BLoC compares the old state to the new state. If it sees
  // empty props match ([] == []), it assumes nothing changed and skips rebuilding the UI.
  //
  // Adding the fields forces BLoC to notice when 'isDone' changes from false to true,
  // triggering an immediate visual update of the checkbox.
}
