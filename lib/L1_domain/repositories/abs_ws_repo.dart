// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractWSRepo<E> {
  Future<Iterable<E>> getAll(int wsId);
  Future<E?> save(E data);
  Future<bool> delete(E data);
}
