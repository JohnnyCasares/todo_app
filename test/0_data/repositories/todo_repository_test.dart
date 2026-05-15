import 'package:either_dart/either.dart' show Either, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class MockTodoRepository extends Mock implements ToDoRepository {}

void main() {
  group('ToDoRepositoryMock', () {
    late MockTodoRepository mockTodoRepository;

    setUp(() {
      mockTodoRepository = MockTodoRepository();
    });

    group('should return List of ToDoCollection', () {
      test('when mock repo returns a List of Todo\'s', () async {});
    });
  });
}
