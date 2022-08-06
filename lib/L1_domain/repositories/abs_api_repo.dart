// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractApiRepo<Get, Upsert> {
  Future<List<Get>> getAll([dynamic query]);
  Future<Get?> save(Upsert data);
  Future<bool> delete(int id);
}
