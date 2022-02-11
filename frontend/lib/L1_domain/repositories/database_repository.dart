// Copyright (c) 2022. Alexandr Moroz

import '../entities/base.dart';

abstract class DBModel {}

abstract class DBRepository<E extends BaseEntity, M extends DBModel> {
  Future<Iterable<E>> getAll(dynamic params);

  Future<dynamic> save(E entity, M? model);

  Future delete(E entity, M? model);
}
