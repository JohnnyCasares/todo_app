import 'package:uuid/uuid.dart';

class UniqueId {
  // 1. THE PRIVATE CONSTRUCTOR
  // The "_" means only this class can talk to itself.
  // It ensures the 'value' can't be set randomly from the outside.
  const UniqueId._(this.value);

  final String value;

  // 2. THE "GENERATOR" FACTORY
  // When you call UniqueId(), you want a brand new identity.
  // It handles the 'how' (Uuid.v4) so you don't have to.
  factory UniqueId() {
    return UniqueId._(const Uuid().v4());
  }

  // 3. THE "RECONSTRUCTOR" FACTORY
  // Used when you already have an ID (from a database or a hardcoded test string).
  // It takes your typed string and "feeds" it into the private constructor.
  factory UniqueId.fromUniqueString(String uniqueString) {
    return UniqueId._(uniqueString);
  }
}

class CollectionId extends UniqueId {
  const CollectionId._(String value) : super._(value);

  factory CollectionId() {
    return CollectionId._(const Uuid().v4());
  }

  factory CollectionId.fromUniqueString(String uniqueString) {
    return CollectionId._(uniqueString);
  }
}

class EntryId extends UniqueId {
  const EntryId._(String value) : super._(value);

  factory EntryId() {
    return EntryId._(const Uuid().v4());
  }

  factory EntryId.fromUniqueString(String uniqueString) {
    return EntryId._(uniqueString);
  }
}
