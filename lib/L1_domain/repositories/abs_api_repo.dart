// Copyright (c) 2022. Alexandr Moroz

import '../entities/workspace.dart';

abstract class AbstractApiRepo<E> {
  Future<Iterable<E>> getAll(Workspace ws) => throw UnimplementedError();
  Future<E?> save(E data) => throw UnimplementedError();
  Future<bool> delete(E data) => throw UnimplementedError();
}
