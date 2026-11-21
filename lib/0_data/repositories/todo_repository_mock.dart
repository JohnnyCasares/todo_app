import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements ToDoRepository {
  final toDoCollections = List<ToDoCollection>.generate(
    10,
    (index) => ToDoCollection(
      id: CollectionId.fromUniqueString(index.toString()),
      title: "title $index",
      color: ToDoColor(colorIndex: index % ToDoColor.predefinedColors.length),
    ),
  );

  // Entries are stored per collection. The old flat list assigned entries by
  // position (collection N = entries N*10..N*10+9) using int.parse on the
  // collection id, which breaks for new collections whose ids are UUIDs.
  // Seeded collections keep the same 10 entries (ids "0".."99") as before.
  late final Map<CollectionId, List<ToDoEntry>> toDoEntries = {
    for (var c = 0; c < toDoCollections.length; c++)
      toDoCollections[c].id: List.generate(10, (i) {
        final index = c * 10 + i;
        return ToDoEntry(
          description: 'To Do Entry description $index',
          isDone: false,
          id: EntryId.fromUniqueString(index.toString()),
        );
      }),
  };

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
    final selectedEntryItem = toDoEntries[collectionId]
        ?.where((element) => element.id == entryid)
        .firstOrNull;

    if (selectedEntryItem == null) {
      return Future.value(
        Left(
          ServerFailure(
            stackTrace:
                'Entry ${entryid.value} not found in collection ${collectionId.value}',
          ),
        ),
      );
    }

    return Future.delayed(
      Duration(milliseconds: 300),
      () => Right(selectedEntryItem),
    );
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
    CollectionId collectionId,
  ) {
    // A collection with no entries yet (e.g. one just created) returns [].
    final entryIds = (toDoEntries[collectionId] ?? const <ToDoEntry>[])
        .map((e) => e.id)
        .toList();

    return Future.delayed(Duration(milliseconds: 300), () => Right(entryIds));
  }

  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry({
    required CollectionId collectionId,
    required EntryId entryId,
  }) async {
    final entries = toDoEntries[collectionId];
    final index = entries?.indexWhere((element) => element.id == entryId) ?? -1;

    if (entries == null || index == -1) {
      return Left(
        ServerFailure(
          stackTrace:
              'Entry ${entryId.value} not found in collection ${collectionId.value}',
        ),
      );
    }

    final entryToUpdate = entries[index];
    final updatedEntry = entryToUpdate.copyWith(isDone: !entryToUpdate.isDone);

    entries[index] = updatedEntry;

    return Future.delayed(
      Duration(milliseconds: 100),
      () => Right(updatedEntry),
    );
  }

  @override
  Future<Either<Failure, bool>> createToDoCollection(
    ToDoCollection collection,
  ) {
    toDoCollections.add(collection);
    toDoEntries[collection.id] = [];
    return Future.delayed(const Duration(milliseconds: 100), () => Right(true));
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry({
    required CollectionId collectionId,
    required ToDoEntry entry,
  }) {
    final entries = toDoEntries[collectionId];

    if (entries == null) {
      return Future.value(
        Left(
          ServerFailure(
            stackTrace: 'Collection ${collectionId.value} not found',
          ),
        ),
      );
    }

    entries.add(entry);
    return Future.delayed(const Duration(milliseconds: 150), () => Right(true));
  }
}
