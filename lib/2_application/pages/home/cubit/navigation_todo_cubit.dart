import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

part 'navigation_todo_cubit_state.dart';

class NavigationTodoCubit extends Cubit<NavigationTodoCubitState> {
  NavigationTodoCubit() : super(NavigationTodoCubitState());

  void selectedToDoCollectionChange(CollectionId collectionId) {
    emit(NavigationTodoCubitState(selectedCollectionId: collectionId));
  }

  void secondBodyHasChanged({required bool isSecondBodyDisplayed}) {
    emit(
      NavigationTodoCubitState(
        isSecondBodyDisplayed: isSecondBodyDisplayed,
        selectedCollectionId: state.selectedCollectionId,
      ),
      //Question: Why are we passing the selectedCollectionId using the state's value?
      //Answer: Because if the screen size changes while we are looking at a specific collection, we want to make sure the changes accurately apply to the
      //current screen.
    );
  }
}
