import 'package:flutter/material.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';

class ToDoEntryLoaded extends StatelessWidget {
  const ToDoEntryLoaded({
    super.key,
    required this.todoEntry,
    required this.onChanged,
  });

  final ToDoEntry todoEntry;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(todoEntry.description),
      value: todoEntry.isDone,
      onChanged: onChanged,
    );
  }
}
