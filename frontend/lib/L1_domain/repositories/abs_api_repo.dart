// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

abstract class AbstractApiRepo<E extends RPersistable, U> {
  Future<List<E>> getAll();
  Future<E?> save(U data);
  Future<bool> delete(int id);
}
