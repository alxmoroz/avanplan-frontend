// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractApiRepo<E> {
  Future<List<E>> getAll([dynamic query]);
  Future<E?> save(E data);
  Future<bool> delete(int id);
}
