// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractApiRepo<E, R> {
  Future<R?> save(E data) => throw UnimplementedError();
  Future<R?> delete(E data) => throw UnimplementedError();
}
