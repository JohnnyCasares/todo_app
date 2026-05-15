import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollection();

  Future<Either<Failure, ToDoEntry>> readToDoEntry(
    CollectionId collectionId,
    EntryId entryid,
  );

  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
    CollectionId collectionId,
  );
}
