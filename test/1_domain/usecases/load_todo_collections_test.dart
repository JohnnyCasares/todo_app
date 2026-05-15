import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/0_data/repositories/todo_repository_mock.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collections.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:either_dart/either.dart';

class MockTodoRepository extends TodoRepositoryMock {
  late Either<Failure, List<ToDoCollection>> loadToDoCollectionsResult;
  late Either<Failure, ToDoEntry> readToDoEntryResults;
  late Either<Failure, List<EntryId>> loadTodoEntryIdsForCollectionResults;

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollection() async {
    return loadToDoCollectionsResult;
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
    CollectionId collectionId,
    EntryId entryid,
  ) async {
    return readToDoEntryResults;
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
    CollectionId collectionId,
  ) async {
    return loadTodoEntryIdsForCollectionResults;
  }
}

void main() {
  group('LoadToDoCollections UseCase', () {
    late MockTodoRepository mockTodoRepository;
    late LoadToDoCollections loadToDoCollections;
    late LoadTodoEntry loadTodoEntry;
    late LoadTodoEntryIdsForCollection loadTodoEntryIdsForCollection;

    setUp(() {
      mockTodoRepository = MockTodoRepository();
      loadToDoCollections = LoadToDoCollections(
        toDoRepository: mockTodoRepository,
      );
      loadTodoEntry = LoadTodoEntry(toDoRepository: mockTodoRepository);
      loadTodoEntryIdsForCollection = LoadTodoEntryIdsForCollection(
        toDoRepository: mockTodoRepository,
      );
    });

    group('Success', () {
      test('should return Right with a list of ToDoCollection', () async {
        // Arrange
        final tList = [
          ToDoCollection(
            id: CollectionId.fromUniqueString('0'),
            title: "title 0",
            color: ToDoColor(colorIndex: 0),
          ),
        ];

        mockTodoRepository.loadToDoCollectionsResult = Right(tList);

        final result = await loadToDoCollections.call(NoParams());

        expect(result.isRight, true);

        result.fold(
          (l) => fail('Should have been a Right (List<ToDoCollection>)'),
          (r) {
            expect(r.length, 1);
            expect(r.first.id.value, '0');
          },
        );
      });
      test('should return Right with a ToDoEntry', () async {
        final tTodoEntry = ToDoEntry(
          description: 'Test',
          isDone: false,
          id: EntryId.fromUniqueString('test'),
        );

        mockTodoRepository.readToDoEntryResults = Right(tTodoEntry);

        final result = await loadTodoEntry.call(
          ToDoEntryIdParam(
            collectionId: CollectionId.fromUniqueString(''),
            entryId: EntryId.fromUniqueString('test'),
          ),
        );

        expect(result.isRight, true);
        result.fold((l) => fail('Should have been a Right (ToDoEntry)'), (r) {
          expect(r.description, 'Test');
          expect(r.isDone, false);
        });
      });
      test('should return Right with an EntryId', () async {
        final tEntryId = [EntryId.fromUniqueString('test')];
        mockTodoRepository.loadTodoEntryIdsForCollectionResults = Right(
          tEntryId,
        );
        final result = await loadTodoEntryIdsForCollection.call(
          CollectionIdParam(
            collectionId: CollectionId.fromUniqueString('test'),
          ),
        );

        expect(result.isRight, true);
        result.fold((l) => fail('Should have been a Right (EntryId)'), (r) {
          expect(r.length, 1);
          expect(r.first.value, 'test');
        });
      });
    });
  });
}
