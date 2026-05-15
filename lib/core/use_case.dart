import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

class ToDoEntryIdParam extends Params {
  ToDoEntryIdParam({required this.collectionId, required this.entryId});
  final CollectionId collectionId;
  final EntryId entryId;

  @override
  List<Object?> get props => [collectionId, entryId];
}

class CollectionIdParam extends Params {
  CollectionIdParam({required this.collectionId});
  final CollectionId collectionId;

  @override
  List<Object?> get props => [collectionId];
}
