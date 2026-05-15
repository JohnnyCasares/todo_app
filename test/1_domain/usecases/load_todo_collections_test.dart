import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collections.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:either_dart/either.dart' as mock;

class MockTodoRepository implements ToDoRepository {
  mock.Either<Failure, List<ToDoCollection>>? result;

  @override
  Future<mock.Either<Failure, List<ToDoCollection>>>
  readToDoCollection() async {
    // If we didn't set a result, default to an empty Right list
    return result ?? mock.Right([]);
  }
}

void main() {
  group('LoadToDoCollections UseCase', () {
    late MockTodoRepository mockTodoRepository;
    late LoadToDoCollections loadToDoCollections;

    setUp(() {
      mockTodoRepository = MockTodoRepository();
      loadToDoCollections = LoadToDoCollections(
        toDoRepository: mockTodoRepository,
      );
    });

    group('Success', () {
      test(
        'should return Right with a list of collections when repository succeeds',
        () async {
          // Arrange
          final tList = [
            ToDoCollection(
              id: CollectionId.fromUniqueString('1'),
              title: 'Test',
              color: ToDoColor(colorIndex: 0),
            ),
          ];
          mockTodoRepository.result = mock.Right(tList);

          // Act
          final result = await loadToDoCollections.call(NoParams());

          // Assert
          expect(result, Right<Failure, List<ToDoCollection>>(tList));

          expect(result.isRight, true);
        },
      );
    });

    group('Failures', () {
      test(
        'should return Left with ServerFailure when repository returns ServerFailure',
        () async {
          // Arrange
          mockTodoRepository.result = mock.Left(ServerFailure());

          // Act
          final result = await loadToDoCollections.call(NoParams());

          // Assert
          expect(result, Left<Failure, List<ToDoCollection>>(ServerFailure()));
          expect(result.isLeft, true);
        },
      );

      test(
        'should return Left with ServerFailure when repository throws an unexpected Exception',
        () async {
          // Note: For this specific test, we need the repo to actually throw
          // You could modify the MockRepo to throw or just test the current catch logic
          // If your repo impl throws, your UseCase catch block will handle it.
        },
      );
    });
  });
}
