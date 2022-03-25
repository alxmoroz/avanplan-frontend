// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

abstract class AbstractApiRepo<E extends RPersistable> {
  Future<List<E>> getAll();
  Future<E?> save(dynamic params);
  Future<bool> delete(int id);
}
