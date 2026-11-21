import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/0_data/repositories/todo_repository_mock.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/core/use_case.dart';

class FakeTodoRepository extends TodoRepositoryMock {
  late Either<Failure, bool> createToDoEntryResult;
  Exception? throwOnCreate;
  CollectionId? receivedCollectionId;
  ToDoEntry? receivedEntry;

  @override
  Future<Either<Failure, bool>> createToDoEntry({
    required CollectionId collectionId,
    required ToDoEntry entry,
  }) async {
    receivedCollectionId = collectionId;
    receivedEntry = entry;
    if (throwOnCreate != null) throw throwOnCreate!;
    return createToDoEntryResult;
  }
}

void main() {
  group('CreateToDoEntry UseCase', () {
    late FakeTodoRepository fakeRepository;
    late CreateToDoEntry createToDoEntry;

    final tCollectionId = CollectionId.fromUniqueString('collection-1');
    final tEntry = ToDoEntry(
      description: 'Buy milk',
      isDone: false,
      id: EntryId.fromUniqueString('entry-1'),
    );

    setUp(() {
      fakeRepository = FakeTodoRepository();
      createToDoEntry = CreateToDoEntry(toDoRepository: fakeRepository);
    });

    group('Success', () {
      test('returns Right(true) and passes collectionId and entry', () async {
        fakeRepository.createToDoEntryResult = Right(true);

        final result = await createToDoEntry.call(
          ToDoEntryParams(collectionId: tCollectionId, entry: tEntry),
        );

        expect(result.isRight, true);
        expect(result.right, true);
        expect(fakeRepository.receivedCollectionId, tCollectionId);
        expect(fakeRepository.receivedEntry, tEntry);
      });
    });

    group('Failure', () {
      test('returns Left when the repository returns a Failure', () async {
        fakeRepository.createToDoEntryResult = Left(ServerFailure());

        final result = await createToDoEntry.call(
          ToDoEntryParams(collectionId: tCollectionId, entry: tEntry),
        );

        expect(result.isLeft, true);
        expect(result.left, isA<ServerFailure>());
      });

      test('returns Left(ServerFailure) when the repository throws', () async {
        fakeRepository.throwOnCreate = Exception('network down');

        final result = await createToDoEntry.call(
          ToDoEntryParams(collectionId: tCollectionId, entry: tEntry),
        );

        expect(result.isLeft, true);
        expect(result.left, isA<ServerFailure>());
      });
    });
  });
}
