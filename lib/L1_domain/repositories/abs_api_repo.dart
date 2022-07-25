// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/base_upsert.dart';
import '../entities/base_entity.dart';

abstract class AbstractApiRepo<E extends RPersistable, U extends BaseUpsert, Q extends BaseSchema> {
  Future<List<E>> getAll([Q? query]);
  Future<E?> save(U data);
  Future<bool> delete(int id);
}
