// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractApiWSRepo<E> {
  Future<List<E>> getAll(int wsId);
  Future<E?> save(E data);
  Future<bool> delete(E data);
}
