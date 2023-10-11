// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractApiRepo<Get, Update> {
  Future<Iterable<Get>> getAll() => throw UnimplementedError();
  Future<Get?> save(Update data) => throw UnimplementedError();
  Future<Get?> delete(Update data) => throw UnimplementedError();
}
