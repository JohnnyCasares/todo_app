import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/0_data/repositories/todo_repository_mock.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';

void main() {
  group('TodoRepositoryMock', () {
    late TodoRepositoryMock repository;

    setUp(() {
      repository = TodoRepositoryMock();
    });

    test('seeded collections still have 10 entries each', () async {
      for (var c = 0; c < 10; c++) {
        final result = await repository.readToDoEntryIds(
          CollectionId.fromUniqueString(c.toString()),
        );
        expect(result.right.length, 10, reason: 'collection $c');
        expect(result.right.first.value, (c * 10).toString());
      }
    });

    test(
      'a new collection (UUID id) returns an empty list, not an error',
      () async {
        final newCollection = ToDoCollection.empty().copyWith(title: 'new');
        await repository.createToDoCollection(newCollection);

        final result = await repository.readToDoEntryIds(newCollection.id);

        expect(result.isRight, true);
        expect(result.right, isEmpty);
      },
    );

    test(
      'a created entry shows up in its collection and can be read',
      () async {
        final newCollection = ToDoCollection.empty().copyWith(title: 'new');
        await repository.createToDoCollection(newCollection);
        final entry = ToDoEntry(
          description: 'Buy milk',
          isDone: false,
          id: EntryId(),
        );

        final created = await repository.createToDoEntry(
          collectionId: newCollection.id,
          entry: entry,
        );
        final ids = await repository.readToDoEntryIds(newCollection.id);
        final read = await repository.readToDoEntry(newCollection.id, entry.id);

        expect(created.right, true);
        expect(ids.right, [entry.id]);
        expect(read.right, entry);
      },
    );

    test('creating an entry in an unknown collection returns Left', () async {
      final result = await repository.createToDoEntry(
        collectionId: CollectionId.fromUniqueString('does-not-exist'),
        entry: ToDoEntry.empty(),
      );

      expect(result.isLeft, true);
      expect(result.left, isA<ServerFailure>());
    });
  });
}
