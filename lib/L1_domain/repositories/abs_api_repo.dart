// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractApiRepo<Get, Update> {
  Future<Iterable<Get>> getAll() => throw UnimplementedError();
  Future<Iterable<Get>> getAllWithWS(int wsId) => throw UnimplementedError();

  Future<Get?> getOne(int id) => throw UnimplementedError();
  Future<Get?> getOneWithWS(int wsId, int id) => throw UnimplementedError();

  Future<Get?> save(Update data) => throw UnimplementedError();
  Future<Get?> delete(Update data) => throw UnimplementedError();
}
