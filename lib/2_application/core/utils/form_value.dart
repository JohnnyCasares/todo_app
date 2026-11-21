import 'package:equatable/equatable.dart';

class FormValue<T> with EquatableMixin {
  final T value;
  final ValidationStatus validationStatus;
  FormValue({required this.value, required this.validationStatus});
  @override
  // TODO: implement props
  List<Object?> get props => [value, validationStatus];
}

enum ValidationStatus { error, success, pending }
