// Copyright (c) 2022. Alexandr Moroz

import '../entities/base.dart';

abstract class AbstractDBModel<E extends BaseEntity> {
  Future update(E entity);
  E toEntity();
}

typedef Filter<E extends BaseEntity> = bool Function(E e);

abstract class AbstractDBRepo<M extends AbstractDBModel, E extends BaseEntity> {
  Future<Iterable<E>> get([Filter<E>? filter]);
  Future<E?> getOne([Filter<E>? filter]);
  // Future<M> create(E entity);
  Future update(E entity);
  Future delete(E entity);
}
