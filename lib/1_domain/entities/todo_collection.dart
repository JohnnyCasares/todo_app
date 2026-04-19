import 'package:todo_app/1_domain/entities/unique_id.dart';

import 'todo_color.dart';

class ToDoCollection {
  final CollectionId id;
  final String title;
  final ToDoColor color;

  ToDoCollection({required this.id, required this.title, required this.color});

  factory ToDoCollection.empty() {
    return ToDoCollection(
      id: CollectionId(),
      title: '',
      color: ToDoColor(colorIndex: 0),
    );
  }
}
