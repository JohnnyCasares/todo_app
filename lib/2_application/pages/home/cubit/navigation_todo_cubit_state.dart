part of 'navigation_todo_cubit.dart';

class NavigationTodoCubitState extends Equatable {
  final CollectionId? selectedCollectionId;
  const NavigationTodoCubitState({this.selectedCollectionId});

  @override
  List<Object?> get props => [selectedCollectionId];
}
