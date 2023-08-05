// Copyright (c) 2022. Alexandr Moroz

import '../entities/workspace.dart';

abstract class AbstractWSRepo<E> {
  Future<Iterable<E>> getAll(Workspace ws) => throw UnimplementedError();
  Future<E?> save(Workspace ws, E data) => throw UnimplementedError();
  Future<bool> delete(Workspace ws, E data) => throw UnimplementedError();
}
