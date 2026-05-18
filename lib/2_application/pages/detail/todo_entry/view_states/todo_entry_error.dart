import 'package:flutter/material.dart';

class ToDoEntryError extends StatelessWidget {
  const ToDoEntryError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(child: Text('Error on ToDo Entry Page, please try again')),
    );
  }
}
