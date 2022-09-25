// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractApiRepo<E> {
  // TODO(san-smith): я бы не рекомендовал использовать dynamic - легко выстрелить в ногу.
  // Лучше попробовать через дженерик, на крайняк `Object?`
  Future<List<E>> getAll([dynamic query]);
  Future<E?> save(E data);
  Future<bool> delete(int id);
}
