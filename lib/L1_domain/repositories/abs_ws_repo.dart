// Copyright (c) 2022. Alexandr Moroz

import '../entities/workspace.dart';

abstract class AbstractWSRepo<E> {
  Future<Iterable<E>> getAll(Workspace ws);
  Future<E?> save(Workspace ws, E data);
  Future<bool> delete(Workspace ws, E data);
}
