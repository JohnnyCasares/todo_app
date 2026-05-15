import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements ToDoRepository {
  final List<ToDoEntry> toDoEntries = List.generate(
    100,
    (index) => ToDoEntry(
      description: 'To Do Entry description $index',
      isDone: false,
      id: EntryId.fromUniqueString(index.toString()),
    ),
  );
  final toDoCollections = List<ToDoCollection>.generate(
    10,
    (index) => ToDoCollection(
      id: CollectionId.fromUniqueString(index.toString()),
      title: "title $index",
      color: ToDoColor(colorIndex: index % ToDoColor.predefinedColors.length),
    ),
  );

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollection() {
    try {
      return Future.delayed(
        Duration(milliseconds: 200),
        () => Right(toDoCollections),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
    CollectionId collectionId,
    EntryId entryid,
  ) {
    {
      try {
        final selectedEntryItem = toDoEntries.firstWhere(
          (element) => element.id == entryid,
        );

        return Future.delayed(
          Duration(milliseconds: 300),
          () => Right(selectedEntryItem),
        );
      } on Exception catch (e) {
        return Future.value(Left(ServerFailure(stackTrace: e.toString())));
      }
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
    CollectionId collectionId,
  ) {
    try {
      final startIndex = int.parse(collectionId.value) * 10;
      final endIndex = startIndex + 10;
      final entryIds = toDoEntries
          .sublist(startIndex, endIndex)
          .map((e) => e.id)
          .toList();

      return Future.delayed(Duration(milliseconds: 300), () => Right(entryIds));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
