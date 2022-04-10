// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/base_upsert_schema.dart';
import '../entities/base_entity.dart';

abstract class AbstractApiRepo<E extends RPersistable, U extends BaseUpsert> {
  Future<List<E>> getAll();
  Future<E?> save(U data);
  Future<bool> delete(int id);
}
